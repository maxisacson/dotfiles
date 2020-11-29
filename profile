# vim: set filetype=sh :
# Source this file in ~/.profile

# PATH
PATH="$HOME/.local/opt/bin:$PATH"

if [ -d "$HOME/.local/opt/neovim/bin" ]; then
    PATH="$HOME/.local/opt/neovim/bin:$PATH"
fi

if [ -d "$HOME/.local/opt/lineage/platform-tools" ]; then
    PATH="$HOME/.local/opt/lineage/platform-tools:$PATH"
fi

if [ -d "$HOME/.local/opt/android-studio/bin" ]; then
    PATH="$HOME/.local/opt/android-studio/bin:$PATH"
fi

if [ -d "$HOME/Android/Sdk/platform-tools" ]; then
    PATH="$HOME/Android/Sdk/platform-tools:$PATH"
fi
