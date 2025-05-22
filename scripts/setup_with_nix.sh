#!/usr/bin/env bash

# generic setup script for any device that has nix.

# parameters
#
# DOTFILES_DEVICE: device name. used to select which device-* folder to install

device="${DOTFILES_DEVICE?}"

stow="stow --dotfiles -t ${HOME}"

# check dependencies

function ensure_installed() {
  if ! [ -x $(command -v "${1}") ]; then
    echo "FATAL: ${1} is not installed" > /dev/stderr
    exit 1
  fi 
}

set -e

ensure_installed nix 
ensure_installed stow 

cd "$(dirname "$0")"
cd ..

if [ -x $(command -v "home-manager") ]; then
echo " * found nix home-manager"
echo "-- updating nix home-manager state --"
${stow} nix-homemanager 
home-manager switch
else 
echo " * did not find nix home-manager"
echo "--- bootstrapping nix home-manager ---" 
${stow} nix-homemanager 
nix run home-manager -- switch 
fi


echo "-- installing dotfiles --"

${stow} common app-nvim app-nvim-2025 app-pandoc "device-${device}"

