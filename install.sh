#!/bin/bash

TMP_DIR="/tmp/dot"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname)"

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
readonly XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
readonly XDG_BIN_DIR="${XDG_BIN_DIR:-$XDG_DATA_HOME/bin}"

readonly PACKAGES=("git" "curl" "neovim" "fish" "starship")

readonly CONFIG_DIR="${SCRIPT_DIR}/config"
readonly USER_BIN_DIR="${XDG_BIN_HOME}"

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

function install-darwin() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is required to run this script."
    echo "Please refer to the following link to install Homebrew"
    echo "Ref : https://brew.sh/ja/"
  fi

  echo "Updating system and installing dependencies..."
  brew update
  brew install "${PACKAGES[@]}"

  install-mise
  install-aqua
  install-rust
}

function install-linux() {
  # upgrate system and install dependencies
  echo "Updating system and installing dependencies..."
  sudo pacman -Sy
  sudo pacman -S --needed "${PACKAGES[@]}"

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
  if [ "$OS" = "Darwin" ]; then
    install-darwin
  elif [ "$OS" = "Linux" ]; then
    install-linux
  fi
  deploy
}
main
