#!/usr/bin/bash

# initialises st-andrews lab machines with my dotfiles and a newer version of rust
# (home directories reset on reboot)
#
# source this file

$(return 0 > /dev/null 2>&1) || ( echo "please do not run this directly. source it instead." && exit 1 )

echo "setting up dotfiles"

# get rid of the defaults
rm -rf ~/.bashrc ~/.bash_profile ~/.profile ~/.tmux.conf ~/.ipython ~/.bashrc.d ~/.gitconfig

# load dotfiles from network home
stow -t ${HOME} -d /cs/home/nd60/dotfiles common app-nvim device-stacs

# apply them
source ~/.profile
source ~/.bashrc

echo "..done!"

echo "setting up rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
source ~/.cargo/env
rustup component add rust-analyzer
echo "..done!"

echo "setting up haskell"
export BOOTSTRAP_HASKELL_NONINTERACTIVE=0 
export BOOTSTRAP_HASKELL_INSTALL_HLS=1 
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
unset BOOTSTRAP_HASKELL_NONINTERACTIVE
unset BOOTSTRAP_HASKELL_INSTALL_HLS
source ~/.ghcup/env
echo "..done!"

