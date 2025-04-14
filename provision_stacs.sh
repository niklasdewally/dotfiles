#!/usr/bin/bash

$(return 0 > /dev/null 2>&1) || ( echo "please do not run this directly. source it instead." && exit 1 )

echo "setting up dotfiles"

rm -rf ~/.bashrc ~/.bash_profile ~/.profile ~/.tmux.conf ~/.ipython ~/.bashrc.d ~/.gitconfig

stow -t ${HOME} -d /cs/home/nd60/dotfiles common app-nvim device-stacs

source ~/.profile
source ~/.bashrc


echo "..done!"

echo "setting up rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
source ~/.cargo/env
echo "..done!"

