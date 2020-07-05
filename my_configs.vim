set nocompatible
filetype plugin indent on

call plug#begin('~/.vim_runtime/my_plugins/plugged')
" Language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'rust-lang/rust.vim'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

colorscheme wombat
set hidden
set mouse=a
set foldmethod=syntax

command W w

let g:tagbar_ctags_bin = "$HOME/usr/bin/ctags" 
let g:rust_clip_command = 'xclip -selection clipboard'

nmap <leader>t :Tagbar<CR>
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>
