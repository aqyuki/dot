#!/bin/bash
set -euo pipefail

OS="$(uname)"
readonly OS

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR

readonly DEPENDENCIES=("neovim" "fish" "starship" "ghq" "mise" "lazygit")
readonly CONFIG_DIR="${SCRIPT_DIR}/config"
readonly TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

function install-arch() {
  if command -v yay >/dev/null 2>&1; then
    yay -Syu
    yay -S --needed --noconfirm "${DEPENDENCIES[@]}"
  else
    sudo pacman -Syu
    sudo pacman -S --needed --noconfirm "${DEPENDENCIES[@]}"
  fi
}

function install-darwin() {
  echo "Auto install of packages is not supported on Darwin. Please install the following packages"
  echo "${DEPENDENCIES[@]}"
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

case "$1" in
install)
  if [[ "$OS" == "Linux" && -f /etc/arch-release ]]; then
    install-arch
  elif [[ "$OS" == "Darwin" ]]; then
    install-darwin
  else
    echo "Unsupported OS: $OS"
    exit 1
  fi
  ;;
deploy)
  deploy
  ;;
*)
  echo "Error : Invalid command \"$1\""
  exit 1
  ;;
esac
