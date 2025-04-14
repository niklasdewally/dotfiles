#!/usr/bin/bash

# source this file
$(return 0 > /dev/null 2>&1) || ( echo "please do not run this directly. source it instead." && exit 1 )

echo "setting up haskell"
export BOOTSTRAP_HASKELL_NONINTERACTIVE=0 
export BOOTSTRAP_HASKELL_INSTALL_HLS=1 
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
unset BOOTSTRAP_HASKELL_NONINTERACTIVE
unset BOOTSTRAP_HASKELL_INSTALL_HLS
source ~/.ghcup/env
echo "..done!"

