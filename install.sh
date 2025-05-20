#!/bin/bash

TMP_DIR="/tmp/dot"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
readonly XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
readonly XDG_BIN_DIR="${XDG_BIN_DIR:-$XDG_DATA_HOME/bin}"

readonly DEPENDENCIES=("git" "curl")
readonly PACKAGES=("neovim" "fish" "starship")

readonly CONFIG_DIR="${SCRIPT_DIR}/config"
readonly USER_BIN_DIR="${XDG_BIN_HOME}"

function pre-install() {
  # create temporary directory
  rm -rf "$TMP_DIR"
  mkdir --parent "$TMP_DIR"
  mkdir --parent "$USER_BIN_DIR"
}

function post-install() {
  #remove temporary directory
  rm -rf "$TMP_DIR"
}

function install-aqua() {
  if aqua version >/dev/null 2>&1; then
    echo "aqua already installed."
    return
  fi

  echo "Installing aqua..."
  curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.1.2/aqua-installer | bash
}

function install-mise() {
  if mise version >/dev/null 2>&1; then
    echo "mise already installed."
    return
  fi

  echo "Installing mise..."
  curl https://mise.run | MISE_INSTALL_PATH="${USER_BIN_DIR}/mise" sh
}

function install-rust() {
  if rustup --version >/dev/null 2>&1; then
    echo "Rust is already installed."
    return
  fi

  echo "Installing rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function install() {
  pre-install

  # upgrate system and install dependencies
  echo "Updating system and installing dependencies..."
  sudo pacman -Sy
  sudo pacman -S --needed "${DEPENDENCIES[@]}"

  # if `yay` is not installed, install it.
  if ! command -v yay >/dev/null 2>&1; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git "$TMP_DIR/yay"

    cd /tmp/yay || exit 1
    makepkg -sir --noconfirm

    cd "$SCRIPT_DIR" || exit 1
    rm -rf /tmp/yay

    echo "Installed yay successfully."
  fi

  echo "Installing packages..."
  yay -S --needed "${PACKAGES[@]}"

  # install from github
  install-mise
  install-aqua
  install-rust

  post-install
}

function deploy() {
  for item in "$CONFIG_DIR"/*; do
    name=$(basename "$item")

    src="${CONFIG_DIR}/${name}"
    dst="${XDG_CONFIG_HOME}/${name}"

    if [[ -e "$src" ]]; then
      if [[ -L "$dst" || -e "$dst" ]]; then
        echo "[Skip] ${item}: ${dst} already exists."
      else
        ln -s "$src" "$dst"
        echo "[Linked] ${src} -> ${dst}"
      fi
    else
      echo "[Skip] ${item}: source ${src} does not exist."
    fi
  done
}

function main() {
  install
  deploy
}
main
