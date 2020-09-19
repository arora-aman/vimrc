#!/bin/bash


VIM_RUNTIME=$HOME/.vim_runtime
VIMRC=$HOME/.vimrc
NVIMRC_PATH=$HOME/.config/nvim
NVIMRC=$NVIMRC_PATH/init.vim

curl -fLo $VIM_RUNTIME/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p $NVIMRC_PATH

ln -sf $VIM_RUNTIME/.vimrc $VIMRC
ln -sf $VIM_RUNTIME/.vimrc $NVIMRC_PATH

nvim +PlugInstall +qall


NERDTREE=$VIM_RUNTIME/my_plugins/plugged/nerdtree/nerdtree_plugin
echo "
call g:NERDTreeAddKeyMap({
  \ 'key': 'n',
  \ 'scope': 'FileNode',
  \ 'callback': 'OpenInNewTab',
  \ 'quickhelpText': 'open file in new tab' })


function! OpenInNewTab(node)
    call a:node.activate({'where': 't'})
    call g:NERDTreeCreator.CreateMirror()
    wincmd l
endfunction
" > $NERDTREE/mymappings.vim


