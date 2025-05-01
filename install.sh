#!/bin/bash

TMP_DIR="/tmp/dot"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

readonly DEPENDENCIES=("git" "curl")
# TEMPORARY_DEPENDENCIES is a dependency that is required during installation but will eventually be removed
readonly TEMPORARY_DEPENDENCIES=("github-cli")
readonly PACKAGES=("neovim" "fish" "starship")

readonly CONFIG_DIR="${SCRIPT_DIR}/config"
readonly TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
readonly USER_BIN_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"

function pre-install() {
  # create temporary directory
  rm -rf "$TMP_DIR"
  mkdir --parent "$TMP_DIR"
  mkdir --parent "$USER_BIN_DIR"
}

function post-install() {
  # remove temporary dependencies
  echo "Uninstalling temporary dependencies..."
  yay -Rs --noconfirm "${TEMPORARY_DEPENDENCIES[@]}"

  #remove temporary directory
  rm -rf "$TMP_DIR"
}

function install-aqua() {
  if aqua version >/dev/null 2>&1; then
    echo "Aqua is already installed."
    return
  fi

  echo "Installing aqua from GitHub Releases..."
  mkdir --parent "$TMP_DIR/aqua/dist"
  cd "$TMP_DIR/aqua" || exit 1

  gh release download -R aquaproj/aqua -p aqua_linux_amd64.tar.gz
  gh attestation verify aqua_linux_amd64.tar.gz \
    -R aquaproj/aqua \
    --signer-workflow suzuki-shunsuke/go-release-workflow/.github/workflows/release.yaml
  tar -zxvf "$TMP_DIR/aqua/aqua_linux_amd64.tar.gz" -C "$TMP_DIR/aqua/dist"
  mv "$TMP_DIR/aqua/aqua" "$USER_BIN_DIR/aqua"

  cd "$SCRIPT_DIR" || exit 1
}

function install-mise() {
  if mise version >/dev/null 2>&1; then
    echo "Mise is already installed."
    return
  fi

  echo "Installing mise from GitHub Releases..."
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
  sudo pacman -Syu
  sudo pacman -S --needed "${DEPENDENCIES[@]}" "${TEMPORARY_DEPENDENCIES[@]}"

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
    dst="${TARGET_DIR}/${name}"

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
