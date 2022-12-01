# vim: set filetype=sh :
# Source this file in ~/.profile

function prepend_path() {
    local p="$1"
    case ":$PATH:" in
        *:"$p":*)
            ;;
        *)
            export PATH="$p:$PATH"
            ;;
    esac
}

function prepend_path_if() {
    local p="$1"
    if [ -d "$p" ]; then
        prepend_path "$p"
    fi
}


prepend_path "$HOME/.local/opt/bin"

prepend_path_if "$HOME/.local/opt/neovim/bin"
prepend_path_if "$HOME/.local/opt/lineage/platform-tools"
prepend_path_if "$HOME/.local/opt/android-studio/bin"
prepend_path_if "$HOME/Android/Sdk/platform-tools"
prepend_path_if "$HOME/.local/opt/lua-language-server/bin"
prepend_path_if "$HOME/.local/opt/go/bin"

export GOPATH="$HOME/.go"
prepend_path_if "$GOPATH/bin"
