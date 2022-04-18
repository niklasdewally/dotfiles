#!/bin/bash
cp ~/.yadm/cs-profile.sh /cs/home/nd60/.profile.d/profile.sh
cp /cs/home/nd60/.ssh/id_rsa ~/.ssh/id_rsa
cp /cs/home/nd60/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub
# The school overwrites these with symlinks
cp ~/.vimrc /cs/home/nd60/.vimrc
cp ~/.gitconfig /cs/home/nd60/.gitconfig
cd $HOME
yadm restore .
