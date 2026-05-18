#!/usr/bin/env bash

NVIM_PATH=$HOME/.local/opt/nvim

check_dep() {
    if ! command -v "$1" > /dev/null; then
        echo "$1 is required" >&2
        exit 1
    fi
}

get_latest_id() {
    curl -s -L https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.id'
}

get_tag() {
    local id="$1"
    curl -s -L https://api.github.com/repos/neovim/neovim/releases/"$id" | jq -r '.tag_name'
}

get_release() {
    local id="$1"
    local platform="$2"
    local arch="$3"
    local url
    url=$(curl -s -L https://api.github.com/repos/neovim/neovim/releases/"$id" \
        | jq -r ".assets.[] | select(.name | contains(\"$platform\")) | select(.name | contains(\"$arch\")) | select(.name | endswith(\".tar.gz\")) | .browser_download_url")
    curl -L -o nvim.tar.gz "$url"
}

get_platform() {
    local kernel=$(uname)
    if [[ $kernel == "Linux" ]]; then
        echo "linux"
    elif [[ $kernel == "Darwin" ]]; then
        echo "macos"
    fi
}

get_arch() {
    uname -m
}

get_local_release() {
    local basepath=$HOME/.local/opt/nvim
    local latest=$basepath/current
    local path=$(readlink -f "$latest")
    local tag=${path##*/}
    echo $tag
}

check_path() {
    local platform="$1"
    local arch="$2"

    local p="$NVIM_PATH/current/nvim-$platform-$arch/bin"
    case ":$PATH:" in
        *:"$p":*)
            return 0
            ;;
        *)
            echo "$p does not appear to be in PATH"
            return 1
            ;;
    esac
}

update_path() {
    local platform="$1"
    local arch="$2"
    local p="$NVIM_PATH/current/nvim-$platform-$arch/bin"
    local txt="export PATH=\"$p:\$PATH\""
    read -r -p "Append $txt to ~/.bashrc ? [y/n] " ans
    case "$ans" in
        [yY]*)
            echo "$txt" >> ~/.bashrc
            echo "~/.bashrc updated"
            ;;
        *)
            ;;
    esac
}

main() {
    check_dep curl
    check_dep jq
    check_dep uname
    check_dep readlink

    local id=$(get_latest_id)
    local tag=$(get_tag "$id")

    echo "Latest neovim release: $tag"

    local loc=$(get_local_release)

    local platform=$(get_platform)
    local arch=$(uname -m)

    if [[ $loc == $tag ]]; then
        echo "$tag already in use. Nothing to do."
    else
        cd "$NVIM_PATH"

        if [[ ! -d $tag ]]; then
            mkdir -p "$NVIM_PATH/$tag" || exit 1
            cd "$NVIM_PATH/$tag" || exit 1

            get_release "$id" "$platform" "$arch"
            tar xf nvim.tar.gz && rm nvim.tar.gz
        else
            echo "$tag already present, skipping download."
            cd "$NVIM_PATH/$tag" || exit 1
        fi

        cd "$NVIM_PATH"
        ln -sfn "$tag" current

        echo "neovim $tag installed"
    fi

    check_path "$platform" "$arch" || update_path "$platform" "$arch"
}

main
