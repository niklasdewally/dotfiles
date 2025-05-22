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
stow --dotfiles -t ${HOME} -d /cs/home/nd60/dotfiles common app-nvim device-stacs

# apply them
source ~/.profile
source ~/.bashrc

echo "..done!"

echo "setting up nvim"
nvim -c "LazyUpdate" -c "TSUpdateSync" -c "q"
echo "..done!"

echo "setting up rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
source ~/.cargo/env
rustup component add rust-analyzer
echo "..done!"
