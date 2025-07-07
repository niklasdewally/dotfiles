# environment variables / etc to be ran whenever a login session is started
# this includes gui sessions
#
# usually this is just environment variables
#
# to add a bash / interactive terminal specific setting, use .bashrc instead


# ssh agent

[ $(command -v "keychain") ] && eval $(keychain --eval)

# Path
[ -d "$HOME/.local/bin" ] && export "PATH=$HOME/.local/bin:$PATH"
[ -d "$HOME/.bin" ] && export "PATH=$HOME/.bin:$PATH"
[ -d "$HOME/root/resources/scripts" ] && export "PATH=$HOME/root/resources/scripts:$PATH"
[ -d "/opt/conjure" ] &&  export "PATH=/opt/conjure:$PATH"


# Nix home-manager
[[ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]] && . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# Environments for programming languages

[ -e "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
[ -e "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"


if command -v nvim &> /dev/null; then 
	export EDITOR=nvim
fi

# run local configuration last
if [ -e "$HOME/.profile.local" ]; then
	. "$HOME/.profile.local"
fi

[ -f "/home/nd60/.ghcup/env" ] && . "/home/nd60/.ghcup/env" # ghcup-env
