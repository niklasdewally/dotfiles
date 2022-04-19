#!/bin/bash

# CS machine user configuration
# -----------------------------
# Modified 18/04/2022

# Settings for desktop sessions only
function desktopSettings (){
    gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape_shifted_capslock']"
}

# Convinient symlinks to networked folders in ~/Documents, to replicate personal devices structure
function symlinks () {
    ln -sfn /cs/home/nd60/Documents/src $HOME/src
    ln -sfn /cs/home/nd60/Documents/random $HOME/random
    ln -sfn /cs/home/nd60/Documents/utils $HOME/utils
}

function enviromentVariables(){
    export NETHOME=/cs/home/nd60
}

function loadDotfiles(){
    alias yadm="yadm -Y /cs/home/nd60/.yadm --yadm-data /cs/home/nd60/.yadm/data --yadm-bootstrap $HOME/.config/yadm/bootstrap"
    # Load dotfiles from yadm repo 
    yadm restore .
}

if [ "$DESKTOP_SESSION" == "gnome" ]
then
    desktopSettings
fi

symlinks
enviromentVariables
loadDotfiles
