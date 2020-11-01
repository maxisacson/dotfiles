#!/bin/bash

function append_to_file {
    local s="$1"
    local f="$2"

    local cmd="echo -e \"$s\" >> $f"
    echo $cmd
    eval $cmd
}

function create_dir {
    local d="$1"
    local cmd="mkdir -p \"$d\""
    if [[ ! -d $(eval D=$d && echo $D) ]]; then
        echo $cmd
    else
        echo "$d exists"
    fi
}

function yes_or_no {
    read -p "$1 [Y/n] " choice
    case $choice in
        [Yy]|[Ee]|[Ss]|'')
            echo "y"
            ;;
        [Nn]|[Oo])
            echo "n"
            ;;
        *)
            echo "error"
            ;;
    esac
}

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && dirs +0)"
echo "using \$here=$here"

if [[ -e $HOME/.bash_profile ]]; then
    if [[ $(yes_or_no "Configure .bash_profile?") == "y" ]]; then
        append_to_file "\\n\\n#### User settings ####" " ~/.bash_profile"
        append_to_file "source $here/profile" " ~/.bash_profile"
    fi
else
    if [[ $(yes_or_no "Configure .profile?") == "y" ]]; then
        append_to_file "\\n\\n#### User settings ####" " ~/.profile"
        append_to_file "source $here/profile" " ~/.profile"
    fi
fi

if [[ $(yes_or_no "Configure .bashrc?") == "y" ]]; then
    append_to_file "\\n\\n#### User settings ####" " ~/.bashrc"
    append_to_file "source $here/bashrc" "~/.bashrc"
    if [[ $(yes_or_no "Configure custom prompt in .bashrc?") == "y" ]]; then
        append_to_file "source $here/promptrc" "~/.bashrc"
    fi
fi

if [[ $(yes_or_no "Configure .tmux.conf?") == "y" ]]; then
    append_to_file "source $here/tmux.conf" "~/.tmux.conf"
fi

if [[ $(yes_or_no "Configure init.vim?") == "y" ]]; then
    create_dir "~/.config/nvim"
    append_to_file "so $here/vimrc" "~/.config/nvim/init.vim"
    append_to_file "set guicursor=" "~/.config/nvim/init.vim"
fi

if [[ $(yes_or_no "Configure .vimrc?") == "y" ]]; then
    append_to_file "so $here/vimrc" "~/.vimrc"
fi

if [[ $(yes_or_no "Configure colorscheme?") == "y" ]]; then
    # terminal color theme https://github.com/Mayccoll/Gogh
    bash -c  "$(wget -qO- https://git.io/vQgMr)"
fi
