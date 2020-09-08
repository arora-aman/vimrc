set nocompatible
filetype plugin indent on

call plug#begin('~/.vim_runtime/my_plugins/plugged')

" Easy editing stuff {{{
    Plug 'jiangmiao/auto-pairs' " Might consider vim-scripts/auto-pairs-gentle in the future

    Plug 'preservim/nerdcommenter'
    Plug 'godlygeek/tabular'

    Plug 'tpope/vim-surround'
    vmap Si S(i_<esc>f)

    Plug 'maxbrunsfeld/vim-yankstack'
    let g:yankstack_yank_keys = ['y', 'd']

    nmap <C-p> <Plug>yankstack_substitute_older_paste
    nmap <C-n> <Plug>yankstack_substitute_newer_paste
" }}}

" Programming: Language server support {{{
    Plug 'ludovicchabant/vim-gutentags'
    
    Plug 'dense-analysis/ale'
    nmap <silent> <leader>a <Plug>(ale_next_wrap)

    " Disabling highlighting
    let g:ale_set_highlights = 0

    " Only run linting when saving the file
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 0

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction
" }}}

" Rust: {{{
    Plug 'rust-lang/rust.vim'
    " Required to support :RustPlay from rust.vim
    Plug 'mattn/webapi-vim'
    if has("mac") || has("macunix")
        let g:rust_clip_command = 'pbcopy'
    else
        let g:rust_clip_command = 'xclip -selection clipboard'
    endif
" }}}

" FuzzyFinder: {{{
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    nnoremap <silent> <Leader>g :Rg <C-R><C-W><CR>
" }}}

" Tagbar: Display tags much more nicely {{{
    Plug 'majutsushi/tagbar'
    if ! has('mac')
        let g:tagbar_ctags_bin = "$HOME/usr/bin/ctags" " Compiled Universal tags
    endif

    nmap <leader>t :Tagbar<CR>
"" }}}

" Tex and markdown files {{{
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    Plug 'plasticboy/vim-markdown'
    let vim_markdown_folding_disabled = 1
    
    Plug 'lervag/vimtex'
    let g:tex_flavor = 'latex'

    Plug 'chrisbra/Colorizer' " Color ANSI files
" }}}

" NERDTree: {{{
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    augroup nerdtree
        autocmd!
        autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
        autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
    augroup END

    " Toggle NERDTree
    function! ToggleNerdTree()
        if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
            :NERDTreeFind
        else
            :NERDTreeToggle
        endif
    endfunction
    " toggle nerd tree
    nmap <silent> <leader>n :call ToggleNerdTree()<cr>
    " find the current file in nerdtree without needing to reload the drawer
    nmap <silent> <leader>y :NERDTreeFind<cr>

    let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
    let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
    let NERDTreeNodeDelimiter = "\u263a" " smiley face
    let NERDTreeShowHidden=1
    let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" }}}

" Git: {{{
    Plug 'tpope/vim-fugitive'

    Plug 'airblade/vim-gitgutter'
    let g:gitgutter_enabled=0
    nnoremap <silent> <leader>d :GitGutterToggle<cr>
" }}}

" LightLine: {{{
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'

    let g:lightline = {
        \   'colorscheme': 'wombat',
        \   'active': {
        \       'left': [ [ 'mode', 'paste' ],
        \               [ 'readonly', 'filename', 'modified' ]],
        \       'right': [ [ 'percent', 'lineinfo' ],
        \               [ 'filetype', 'fileformat', 'fileencoding' ],
        \               [ 'gitbranch', 'gitblame'],
        \               [ 'currentfunction',  'cocstatus', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]]
        \   },
        \   'component': {
        \       'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
        \       'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
        \       'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
        \   },
        \   'component_expand': {
        \       'linter_checking': 'lightline#ale#checking',
        \       'linter_infos': 'lightline#ale#infos',
        \       'linter_warnings': 'lightline#ale#warnings',
        \       'linter_errors': 'lightline#ale#errors',
        \       'linter_ok': 'lightline#ale#ok',
        \   },
        \   'component_type': {
        \       'readonly': 'error',
        \       'linter_checking': 'right',
        \       'linter_infos': 'right',
        \       'linter_warnings': 'warning',
        \       'linter_errors': 'error',
        \       'linter_ok': 'right',
        \   },
        \   'component_function': {
        \       'fileencoding': 'helpers#lightline#fileEncoding',
        \       'gitbranch': 'helpers#lightline#gitBranch',
        \       'cocstatus': 'coc#status',
        \       'currentfunction': 'helpers#lightline#currentFunction',
        \       'gitblame': 'helpers#lightline#gitBlame'
        \   },
        \   'tabline': {
        \       'left': [ [ 'tabs' ] ],
        \       'right': [ [ 'close' ] ]
        \   },
        \   'tab': {
        \       'active': [ 'filename', 'modified' ],
        \       'inactive': [ 'filename', 'modified' ],
        \   },
        \ 'separator': { 'left': ' ', 'right': ' ' },
        \ 'subseparator': { 'left': ' ', 'right': ' ' }
        \ }
" }}}

" Startify: Fancy startup screen for vim {{{
    Plug 'mhinz/vim-startify'

    " Don't change to directory when selecting a file
    let g:startify_files_number = 5
    let g:startify_change_to_dir = 0
    let g:startify_custom_header = [ ]
    let g:startify_relative_path = 1
    let g:startify_use_env = 1

    " Custom startup list, only show MRU from current directory/project
    let g:startify_lists = [
    \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
    \  { 'type': function('helpers#startify#listcommits'), 'header': [ 'Recent Commits' ] },
    \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
    \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
    \  { 'type': 'commands',  'header': [ 'Commands' ]       },
    \ ]

    let g:startify_commands = [
    \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
    \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
    \ ]

    let g:startify_bookmarks = [
        \ { 'c': '~/.config/nvim/init.vim' },
        \ { 'g': '~/.gitconfig' },
        \ { 'z': '~/.zshrc' }
    \ ]

    autocmd User Startified setlocal cursorline
    nmap <leader>st :Startify<cr>
" }}}

" Goyo: Presentation stuff {{{
    Plug 'junegunn/limelight.vim'
    Plug 'junegunn/goyo.vim'

    let g:goyo_width=100
    let g:goyo_margin_top = 2
    let g:goyo_margin_bottom = 2
    nnoremap <silent> <leader>z :Goyo<cr>
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
" }}}

" Files: {{{
    Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_working_path_mode = 0

    " Quickly find and open a file in the current working directory
    let g:ctrlp_map = '<C-f>'
    map <leader>j :CtrlP<cr>

    " Quickly find and open a buffer
    map <leader>b :CtrlPBuffer<cr>

    " Quickly find and open a recently opened file
    map <leader>f :CtrlPMRU<CR>

    let g:ctrlp_max_height = 20
    let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

    " `gf` to open file under cursor
    " `<C-w>f` to open file under cursor split horizontally
    Plug 'amix/open_file_under_cursor.vim'
" }}}

" Might delete later: {{{   
    " Tabs: {{{
    Plug 'mkitt/tabline.vim'
    hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
    hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
    hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE
    let g:tablineclosebutton=1
    " }}}

    Plug 'tpope/vim-abolish'
    Plug 'mattn/vim-gist' " :Gist
    Plug 'morhetz/gruvbox' "gruvbox theme
"}}}

call plug#end()

colorscheme wombat
set title " set terminal title
set wildmenu " enhanced command line completion
set hidden
set mouse=a
set foldmethod=syntax
set magic
set clipboard=unnamed " Use system clipboard

" error bells
set noerrorbells
set visualbell
set t_vb=
set tm=500

colorscheme wombat
set hidden
set mouse=a
set foldmethod=syntax
set inccommand=split

autocmd BufWritePost *.vim set foldmethod=indent
