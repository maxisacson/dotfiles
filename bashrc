# vim: set filetype=sh :
# Source this file in ~/.bashrc

# Sage notebook path
export DOT_SAGENB=$HOME/notebooks/sage

# cheat setup
export CHEAT_PATH="/usr/share/cheat:/usr/local/share/cheat:$HOME/.local/lib/python3.7/site-packages/usr/share/cheat"
export CHEAT_USER_DIR="$HOME/git/cheatfiles"
export CHEAT_COLORS=true
export CHEAT_COLORSCHEME="light"
export CHEAT_HIGHLIGHT="white"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias octave='octave --no-gui'
alias cp='cp -i'
alias mv='mv -i'
alias dud='du -ah --max-depth 1'
alias cpd='echo -en "$(pwd)" | xclip -selection primary'
alias xco='xclip -selection primary -o'
alias flw='tail -n+0 -f'
alias cb='xclip -selection primary'

# Set nvim as default editor
export VISUAL="nvim"
export EDITOR="$VISUAL"

# If we're NOT inside TMUX we update the display cache, else set DISPLAY to cached value
function update_disp {
    [ -z "$TMUX" ] && echo $DISPLAY > ~/.display.cache || export DISPLAY="$(cat ~/.display.cache)"
}

# Update the display, unless the current command is $PROMPT_COMMAND
function preexec {
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return
    update_disp
}

# Execute preexec before every simple command
trap 'preexec' DEBUG
