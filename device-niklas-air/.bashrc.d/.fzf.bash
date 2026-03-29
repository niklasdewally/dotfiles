# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/niklas/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/niklas/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/niklas/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/niklas/.fzf/shell/key-bindings.bash"
