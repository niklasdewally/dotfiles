#! /bin/sh
git submodule update --init --recursive
echo "Removing existing symbolic links"
./uninstall.sh 

# Allow dot files in symlink
shopt -s dotglob

echo "Installing Vim config"
ln -rs vim/* $HOME || { echo "Error installing vim config"; }
vim +PlugInstall +qall
#echo "Installing IntelliJ config"
#ln -rs intelliJ/ $HOME || { echo "Error installing IntelliJ config"; }

echo "Installing personal ssh config"
mkdir -p $HOME/.ssh
ln -rs ssh/.ssh/config $HOME/.ssh/config || { echo "Error installing ssh config"; }

echo "Installing Git config"
ln -rs git/* $HOME || { echo "Error installing git config"; }

echo "Installing tmux config"
ln -rs tmux/* $HOME || { echo "Error installing tmux config"; }

echo "Installing zsh config"
ln -rs zsh/* $HOME || { echo "Error installing zsh config"; }

echo "Installing gnuplot config"
ln -rs gnuplot/* $HOME || { echo "Error installing gnuplut config"; }

echo "Installing rclone config"
mkdir -p $HOME/.config/rclone/
ln -rs rclone/rclone.conf $HOME/.config/rclone/rclone.conf

echo "Installing ~/bin scripts"
ln -rs bin/* $HOME/bin || { echo "Error installing bin scripts"; }
ln -rs bin-personal/* $HOME/bin || { echo "Error installing bin scripts"; }
chmod +x $HOME/bin/*
echo "Install Complete!"
