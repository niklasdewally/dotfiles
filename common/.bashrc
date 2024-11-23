# vim: foldmethod=marker foldmarker=#START,#END ft=bash


# run global settings first
[ -e /etc/bashrc ] && source /etc/bashrc

# run completion scripts from .bashrc.d
for file in ~/.bashrc.d/*; do
  . "$file"
done

#START Colour aliases

#https://scriptim.github.io/bash-prompt-generator/
#https://stackoverflow.com/questions/4133904/ps1-line-with-git-current-branch-and-colors

# List of ANSI escape sequences: https://misc.flogisoft.com/bash/tip_colors_and_formatting
# echo -e to allow escape sequences

# escape all non printable chars using \[...\]
# see: https://unix.stackexchange.com/questions/28827/why-is-my-bash-prompt-getting-bugged-when-i-browse-the-history
CLEARALL='\[\e[0m\]'
BOLD='\[\e[1m\]'
CLEARBOLD='\[\e[21m\]'
DIM='\[\e[2m\]'
CLEARDIM='\[\e[22m\]'

# use 16 colour scheme
# foreground cols
COL_DEFAULT='\[\e[39m\]'
BLACK='\[\e[30m\]'
RED='\[\e[31m\]'
GREEN='\[\e[32m\]'
YELLOW='\[\e[33m\]'
BLUE='\[\e[34m\]'
MAGENTA='\[\e[35m\]'
CYAN='\[\e[36m\]'
LGRAY='\[\e[37m\]'

DGRAY='\[\e[90m\]'
LRED='\[\e[91m\]'
LGREEN='\[\e[92m\]'
LYELLOW='\[\e[93m\]'
LBLUE='\[\e[94m\]'
LMAGENTA='\[\e[95m\]'
LCYAN='\[\e[96m\]'
WHITE='\[\e[97m\]'

B_DGRAY='\[\e[01;90m\]'
B_LRED='\[\e[01;91m\]'
B_LGREEN='\[\e[01;92m\]'
B_LYELLOW='\[\e[01;93m\]'
B_LBLUE='\[\e[01;94m\]'
B_LMAGENTA='\[\e[01;95m\]'
B_LCYAN='\[\e[01;96m\]'
B_WHITE='\[\e[01;97m\]'
#END

function i_am_mac() {
  [ $(uname) = "Darwin" ] && [ $(whoami) = "niklas" ]
}

function i_am_labs() {
  [ $(uname) = "Linux" ] && [ $(whoami) = "nd60" ]
}



alias vim=nvim
shopt -s globstar 
set -o vi 

# load pandoc completion if pandoc is on the system
[ -x $(command -v pandoc) ] && eval "$(pandoc --bash-completion)"

# gh cli completion
[ -x $(command -v gh) ] && eval "$(gh completion -s bash)"

# fzf bash completion for nice ctrl-r 
if [ -e /usr/share/doc/fzf/examples/key-bindings.bash ]; then
  source /usr/share/doc/fzf/examples/key-bindings.bash
fi

# colour mac differently than ssh / school devices
if i_am_mac
then 
  COL=$B_LYELLOW
else
  COL=$B_LBLUE
fi

# show previous 3 directories, then use ...
export PROMPT_DIRTRIM=3

colour_my_prompt () {
    local __host="$BOLD\h$CLEARALL"
    local __current_dir="$COL\w$CLEARALL"

    # see https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=1

    local __git="$B_LRED"'$(__git_ps1 " (%s)")'"$CLEARALL"
    export PS1="$__host $__current_dir$__git $COL\$$CLEARALL "
}

colour_my_prompt

# use direnv if installed
_direnv_hook() {
  local previous_exit_status=$?
  trap -- '' SIGINT
  eval "$('/opt/homebrew/bin/direnv' export bash)"
  trap - SIGINT
  return $previous_exit_status
}

_hook_me() {
if ! [[ "${PROMPT_COMMAND:-}" =~ _direnv_hook ]]; then
  PROMPT_COMMAND="_direnv_hook${PROMPT_COMMAND:+\;$PROMPT_COMMAND}"
fi;

_direnv_hook
}

if i_am_mac
then
  _hook_me
fi


[ $(command -v fzf) ] && eval "$(fzf --bash)"
# run local configuration last
[ -e "$HOME/.bashrc.local" ] && . "$HOME/.bashrc.local"


# Created by `pipx` on 2024-11-15 18:12:26
export PATH="$PATH:/Users/niklas/.local/bin"
