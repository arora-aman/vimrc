#!/bin/bash

# set -e
#
VIM_RUNTIME=$HOME/.vim_runtime

curl -fLo $VIM_RUNTIME/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


case $(uname) in
    Darwin)
        brew install neovim universal-tags
        ;;
    Linux)
        # Check for sudo access
        sudo -n &> /dev/null
        if [[ ! $? -eq 0 ]]; then
            echo "Ensure that nvim and universal ctags are installed!"
        else
            snap install universal-ctags
            sudo snap install --beta nvim --classic
        fi
        ;;
esac


MY_PLUGINS_DIR=$VIM_RUNTIME/my_plugins

git clone --depth=1 https://github.com/majutsushi/tagbar.git $MY_PLUGINS_DIR
git clone --depth=1 https://github.com/ludovicchabant/vim-gutentags.git $MY_PLUGINS_DIR
git clone --depth=1 https://github.com/mattn/webapi-vim $MY_PLUGINS_DIR

