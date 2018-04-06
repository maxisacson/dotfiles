# vim: set filetype=sh :
# Source this file in your user config, e.g. add 'source /path/to/here/mybashrc' in ~/.bashrc

# env
if [ "$HOSTNAME" = "phy-intrepid" ]; then
    export BOOSTINCDIR="/usr/local/boost/1_59_0/include/"
    export BOOSTLIBDIR="/usr/local/boost/1_59_0/lib/"
    #export ROOTSYS="/usr/local/root-6.05.02"
    # export ROOTSYS="/usr/local/root-6.06.00"
    export ROOTSYS="/home/max/.local/root-6.12.06"
    source $ROOTSYS/bin/thisroot.sh
    #export BIT=64 # Make LuaJIT run in 64bit mode
    #export TORCHDIR="/home/max/torch/install"
    #source $TORCHDIR/bin/torch-activate
    export VIDYO_AUDIO_FRAMEWORK="ALSA" # fix vidyo audio issues
fi
export PYTHONVENVROOT="$HOME/.virtual_python_environments"
export MATLABDIR="/home/max/.local/MATLAB/R2017b"

# LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$BOOSTLIBDIR:$LD_LIBRARY_PATH

# Sage notebook path
export DOT_SAGENB=$HOME/Dropbox/sage-notebooks/

# PATH
[ "$HOSTNAME" = "phy-intrepid" ] && export PATH="$HOME/.local/llvm-5.0.1/bin:$HOME/.local/SageMath:$HOME/local/SageMath:$MATLABDIR/bin:$PATH:/home/max/local/bin:/home/max/.local/bin"
[ "$HOSTNAME" = "enterprise" ] && export PATH="$MATLABDIR/bin"

export TERM="xterm-256color"

# aliases
if [[ $HOSTNAME = "phy-intrepid" ]] || [[ $HOSTNAME = "enterprise" ]]; then
    alias bestmount='sshfs -o follow_symlinks bestlapp.physics.uu.se:/home/misacson /home/max/remote/bestlapp'
    alias bestumount='fusermount -u /home/max/remote/bestlapp'
    alias bestmux='ssh bestlapp -t tmux'
    alias bestcon='bestmux a -t'
    alias becon='bestcon'
    alias bacon='becon'

    alias abimount='sshfs -o follow_symlinks abisko.hpc2n.umu.se:/home/m/misacson /home/max/remote/abisko'
    alias abiumount='fusermount -u /home/max/remote/abisko'
fi

alias lxmount='sshfs -o follow_symlinks lxplus.cern.ch:/afs/cern.ch/user/m/misacson /home/max/remote/lxplus'
alias lxumount='fusermount -u /home/max/remote/lxplus'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias matlabgui='$MATLABDIR/bin/matlab'
alias matlab='matlab -nosplash -nodesktop'
alias octave='octave --no-gui'
alias root='root -l'
alias cp='cp -i'
alias mv='mv -i'
alias dud='du -h --max-depth 1'
alias cpd='echo -en "$(pwd)" | xclip -selection primary'
alias xco='xclip -selection primary -o'
alias flw='tail -n+0 -f'
alias cb='xclip -selection primary'

# RootCore local setup
rcSetupLocal ()
{
    export rcSetupSite=~/ATLAS/sw/releases;
    export PATHRESOLVER_ALLOWHTTPDOWNLOAD=1;
    source ~/ATLAS/sw/rcSetup/latest/rcSetup.sh $*
}

# Easy-to-use function to set the display number
function set_disp {
    [ -n "$1" ] && export DISPLAY="localhost:${1}.0" || export DISPLAY=":0"
    echo "DISPLAY set to $DISPLAY"
}

# Helper function to set up virtual python environments
function pyenv {
    if [ -z "$1" ]; then
        echo "Usage: pyenv <venv>"
        echo ""
        echo "Available venv's:"
        for x in $PYTHONVENVROOT/*/; do
            echo "    $(basename "$x")"
        done
    else
        source "$PYTHONVENVROOT/${1}/bin/activate"
    fi
}

# Function to start a tmux dev session
function tmux-dev {
    if [[ ! -z "$1" ]]; then
        name="$1"
    else
        OLDIFS=$IFS
        IFS=$'\n'
        name="$(($(echo "$(tmux ls | sed -E -n 's/^dev-([0-9]).*/\1/p')" | sort -nr | head -n 1)+1))"
        IFS=$OLDIFS
    fi

    if tmux has-session -t "dev-$name" 2>/dev/null; then
        echo "Session 'dev-$name' already exist."
        return 1
    fi

    tmux new-session -s "dev-$name" -d -n dev
    tmux split-window -v
    tmux split-window -h
    tmux select-pane -t 0
    tmux resize-pane -D 10
    tmux attach-session -d

    return 0
}

# Function to start laverna
function laverna {
    cd "$HOME/git/laverna"
    gulp
}

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

# custom prompt
# source ~/.mypromptrc
