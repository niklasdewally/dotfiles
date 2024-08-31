# environment variables / etc to be ran whenever a login session is started
# this includes gui sessions
#
# usually this is just environment variables
#
# to add a bash / interactive terminal specific setting, use .bashrc instead


# Path

if [ -d "$HOME/local/bin" ]; then 
    export "PATH=$HOME/local/bin:$PATH"
fi

if [ -d "$HOME/.bin" ]; then 
    export "PATH=$HOME/.bin:$PATH"
fi

if [ -d "$HOME/root/resources/scripts" ]; then 
    export "PATH=$HOME/root/resources/scripts:$PATH"
fi

# Environments for programming languages

if [ -e "~/.ghcup/env" ]
  then
    . "~/.ghcup/env"
fi

if [ -e "~/.cargo/env" ]
  then
    . "~/.cargo/env"
fi

if command -v nvim &> /dev/null; then 
	export EDITOR=nvim
fi

# run local configuration last
if [ -e "$HOME/.profile.local" ]; then
	. "$HOME/.profile.local"
fi
