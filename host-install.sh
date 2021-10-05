#! /bin/sh

NETHOME="/cs"$HOME
echo $NETHOME
echo "Removing existing symbolic links"
./host-uninstall.sh || { echo "Error removing existing symbolic links"; }

# Allow dot files in symlink
shopt -s dotglob

echo "Installing Vim config"
ln -rs vim/* $NETHOME || { echo "Error installing vim config"; }
git submodule update --init --recursive
vim +PluginInstall +qall
vim +"call mkdp#util#install()" +qall # markdown preview installation
#echo "Installing IntelliJ config"
#ln -rs intelliJ/ $HOME || { echo "Error installing IntelliJ config"; }

echo "Installing host ssh config"
mkdir -p $NETHOME/.ssh
ln -rs ssh-host/.ssh/config $NETHOME/.ssh/config || { echo "Error installing ssh config"; }

echo "Installing host Git config"
ln -rs git-host/ $NETHOME || { echo "Error installing git config"; }

echo "Installing tmux config"
ln -rs tmux/ $NETHOME || { echo "Error installing tmux config"; }

#echo "Installing zsh config"
#ln -rs zsh/ $HOME || { echo "Error installing zsh config"; }

echo "Installing gnuplot config"
ln -rs gnuplot/* $NETHOME || { echo "Error installing gnuplut config"; }

echo "Installing ~/bin scripts"
ln -rs bin/* $NETHOME/bin || { echo "Error installing bin scripts"; }
#ln -rs bin-personal/* $HOME/bin || {echo "Error installing bin scripts"; }

echo "Install Complete!"
