#!/bin/bash
# vim: foldmethod=marker: foldmarker=START,END:

shopt -s expand_aliases

###########################
#        SSH AGENT        #
###########################

# use in combination with AddKeysToAgent yes in .ssh/config to only ask for password a given key once per session

eval `ssh-agent -s`

###########################################################################
#                    CS MACHINES PROFILE CONFIGURATION                    #
###########################################################################

export NETHOME=/cs/home/${USER}
export HOME=/home/${USER}

#######################################
#        DESKTOP ONLY SETTINGS        #
#######################################

if [ "$DESKTOP_SESSION" == "gnome" ]
then
    # Make caps lock escape!
    gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape_shifted_capslock']"
fi

##########################
#        SYMLINKS        #
##########################

documents_folders_to_link="src random utils repos"
config_folders_to_link="chezmoi Code rclone emacs doom syncthing" # note that chezmoi deals with ~/.config/nvim for us
share_folders_to_link="nvim" # ./local/share
state_folders_to_link="nvim" # ./local/state

# Restore default symlinks
ln -sfn $NETHOME/Documents $HOME/Documents
ln -sfn $NETHOME/.emacs $HOME/.emacs
ln -sfn $NETHOME/.emacs.d $HOME/.emacs.d
ln -sfn $NETHOME/.vim $HOME/.vim
ln -sfn $NETHOME/.ghcup $HOME/.ghcup
ln -sfn $NETHOME/.hoogle $HOME/.hoogle
rm -rf $HOME/.tmux
ln -sfn $NETHOME/.tmux $HOME/.tmux

## Convinient symlinks to networked folders in ~/Documents, to replicate personal devices structure
for link in $documents_folders_to_link; do
    lsource=$NETHOME/Documents/${link}
    mkdir -p $lsource
    ltarget=$HOME/${link}
    ln -sfn $lsource $ltarget
done

## SSH stuff (note: config is in dotfiles!)
mkdir -p $HOME/.ssh
ssh_files_to_link="authorized_keys id_rsa id_rsa.pub known_hosts"
for link in $ssh_files_to_link; do
    lsource=$NETHOME/.ssh/${link}
    touch $lsource
    ltarget=$HOME/.ssh/${link}
    ln -sfn $lsource $ltarget
done

## Folders to (forcibly) link from $NETHOME/.config to $HOME/.config
mkdir -p $HOME/.config
for link in $config_folders_to_link; do
    lsource=$NETHOME/.config/${link} 
    mkdir -p $lsource
    ltarget=$HOME/.config/${link}
    rm -rf $ltarget
    ln -sfn $lsource $ltarget 
done

## Folders to (forcibly) link from $NETHOME/.local/share to $HOME/.local/share
mkdir -p $HOME/.local/share
for link in $share_folders_to_link; do
    lsource=$NETHOME/.local/share/${link} 
    mkdir -p $lsource
    ltarget=$HOME/.local/share/${link}
    rm -rf $ltarget
    ln -sfn $lsource $ltarget 
done

## Folders to (forcibly) link from $NETHOME/.local/state to $HOME/.local/state
mkdir -p $HOME/.local/state
for link in $state_folders_to_link; do
    lsource=$NETHOME/.local/state/${link} 
    mkdir -p $lsource
    ltarget=$HOME/.local/state/${link}
    rm -rf $ltarget
    ln -sfn $lsource $ltarget 
done

###############################################################
#                    ENVIRONMENT VARIABLES                    #
###############################################################

export NETHOME="$NETHOME"

# stow software from $NETHOME/usr/stow to $NETHOME?/usr
export STOW_DIR="$NETHOME/usr/stow"

#######################################################
#                    STOW DOTFILES                    #
#######################################################
ln -sfn /cs/home/nd60/.dotfiles /home/nd60/.dotfiles
stow --dir="$HOME/.dotfiles" --target="$HOME" -R common labs
