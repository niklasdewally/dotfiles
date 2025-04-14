#!/usr/bin/bash

$(return 0 > /dev/null 2>&1) || ( echo "please do not run this directly. source it instead." && exit 1 )

rm -rf ~/.bashrc ~/.bash_profile ~/.profile ~/.tmux.conf ~/.ipython ~/.bashrc.d ~/.gitconfig

stow -t ${HOME} -d /cs/home/nd60/dotfiles common app-nvim device-stacs

source ~/.profile
source ~/.bashrc

