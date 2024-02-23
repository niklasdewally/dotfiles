# vim: foldmethod=marker foldmarker=#START,#END ft=bash

#START Colour aliases
########################################################
#                    COLOUR ALIASES                    #
########################################################

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

############################################
#        DEVICE DETECTION FUNCTIONS        #
############################################

function i_am_mac() {
  [ $(uname) = "Darwin" ] && [ $(whoami) = "niklas" ]
}

function i_am_labs() {
  [ $(uname) = "Linux" ] && [ $(whoami) = "nd60" ]
}
###########################################
#        RUN GLOBAL SETTINGS FIRST        #
###########################################
# Required for school systems not to break
[ -e /etc/bashrc ] && source /etc/bashrc

######################
#        PATH        #
######################

# Directories to add to path if they exist
# Top is first
DIRS_TO_ADD=(
  "/usr/local/python/bin" # school installs custom python bins here!!
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.go/bin"
  "/opt/homebrew/lib/ruby/gems/3.1.0/bin/"
  "/opt/homebrew/opt/ruby@3.1/bin"
  "$HOME/uni/bin"
  "$HOME/.idris2/bin"
  "$HOME/.pack/bin"
  "$HOME/miniconda3/bin"
  "$HOME/.cabal/bin"
  "$HOME/.ghcup/bin"
  "$HOME/.config/emacs/bin"
  "/usr/local/anaconda3/bin"
)

for path in ${DIRS_TO_ADD[@]}; do
  [ -d  $path ] && LOCAL_PATH="${LOCAL_PATH:+${LOCAL_PATH}:}$path"
done

export PATH=${LOCAL_PATH:+${LOCAL_PATH}:}$PATH

##############################
#        TAB COMPLETE        #
##############################

#bind "set completion-ignore-case on" 2>&1 > /dev/null # ignore case 

# Load completion scripts from .bash
for i in ~/.bash/*-completion.bash; do
  source "$i"
done

# load pandoc completion if pandoc is on the system
[ -x $(command -v pandoc) ] && eval "$(pandoc --bash-completion)"

##############################
#        PS1 / PROMPT        #
##############################

# colour mac differently than ssh / school devices
if i_am_mac
then 
  COL=$B_LYELLOW
else
  COL=$B_LBLUE
fi

[ -e ~/.bash/git-prompt.sh ] && source ~/.bash/git-prompt.sh

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

###################################################################
#        USE DIRENV TO SOURCE .env FILES IN EACH DIRECTORY        #
###################################################################

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
#####################################
#        HASKELL ENVIRONMENT        #
#####################################

if [ -f "~/.ghcup/env" ]
  then
    source "~/.ghcup/env"
fi

#############################################
#        EXPORTS, SHELL OPTIONS, ETC        #
#############################################

export EDITOR=nvim
alias vim=nvim

#when using poetry, shorten the venv name a bit
export POETRY_VIRTUALENVS_PROMPT='{project_name}'

# allow (eg) grep foo **/*.py
shopt -s globstar 


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"
