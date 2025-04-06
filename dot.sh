#!/bin/bash

OS="$(uname)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

readonly OS
readonly SCRIPT_DIR
readonly DEPENDENCIES=("neovim" "ripgrep" "fd" "fish" "starship" "fzf" "ghq" "mise")
readonly MODULES=("git" "nvim" "fish" "mise" "lazygit")
readonly CONFIG_DIR="${SCRIPT_DIR}/config"
readonly TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

function install-arch() {
  if command -v yay >/dev/null 2>&1; then
    yay -Syu
    yay -S --needed --noconfirm "${DEPENDENCIES[@]}"
  else
    sudo pacman -Syu
    sudo pacman -Syu --needed --noconfirm "${DEPENDENCIES[@]}"
  fi
}

function install-darwin() {
  echo "Auto install of packages is not supported on Darwin. Please install the following packages"
  echo "${DEPENDENCIES[@]}"
}

function deploy() {
  for module in "${MODULES[@]}"; do
    src="${CONFIG_DIR}/${module}"
    dst="${TARGET_DIR}/${module}"

    if [[ -d "$src" ]]; then
      if [[ -L "$dst" || -e "$dst" ]]; then
        echo "[Skip] ${module}: ${dst} already exists."
      else
        ln -s "$src" "$dst"
        echo "[Linked] ${src} -> ${dst}"
      fi
    else
      echo "[Skip] ${module}: source directory ${src} does not exist."
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
