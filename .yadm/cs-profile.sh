#!/bin/bash
shopt -s expand_aliases
alias yadm="yadm -Y /cs/home/nd60/.yadm --yadm-data /cs/home/nd60/.yadm/data --yadm-bootstrap $HOME/.config/yadm/bootstrap"

# CS machine user configuration
# -----------------------------
# Modified 18/04/2022

# Settings for desktop sessions only
function desktopSettings (){
    gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape_shifted_capslock']"
}

# Convinient symlinks to networked folders in ~/Documents, to replicate personal devices structure
function symlinks () {
    # Delete unwanted cs symlinks
    unlink .ssh 2> /dev/null
    ln -sfn /cs/home/nd60/Documents/src $HOME/src
    ln -sfn /cs/home/nd60/Documents/random $HOME/random
    ln -sfn /cs/home/nd60/Documents/utils $HOME/utils
}

function enviromentVariables(){
    export NETHOME=/cs/home/nd60
}

function loadDotfiles(){
    # Load dotfiles from yadm repo 
    yadm restore .
    cp /cs/home/nd60/.ssh/id_rsa /home/nd60/.ssh/id_rsa
    cp /cs/home/nd60/.ssh/id_rsa.pub /home/nd60/.ssh/id_rsa.pub
}

if [ "$DESKTOP_SESSION" == "gnome" ]
then
    desktopSettings
fi

symlinks
enviromentVariables
loadDotfiles
