" Vundle 
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'
" My Bundles here:
Bundle 'majutsushi/tagbar'
Bundle 'kevinw/pyflakes-vim'
Bundle 'airblade/vim-gitgutter'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"

" Enable filetype and syntax
syntax on               " enable syntax
filetype on             " enable filetype detection
filetype indent on      " enable filetype-specific indenting
filetype plugin on      " enable filetype-specific plugins
colorscheme darkblue

" General Settings
set nocompatible        " not compatible with the old-fashion vi mode
set number              " show line number
set ruler               " show the cursor position all the time
set showtabline=2       " always show the tab line
set noshowmode          " do not show the vim mode because of lightline
set showcmd             " show the command at the bottom
set title               " set the terminal title 
set bs=2                " allow backspacing over everything in insert mode
set scrolloff=5         " leave 5 lines around the cursor
set history=50          " keep 50 lines of command line history
set autoread            " auto read when file is changed from outside
set wildmenu            " turn on the wild menu
set noerrorbells        " turn off the error bell
set novisualbell        " turn off the visual bell

" Indent settings
set shiftwidth=4        " indent size is 4
set softtabstop=4       " use 4 space to replace one tab
set tabstop=8           " tab size is 8
set expandtab           " use space to indent
set smartindent
set autoindent

" Search settings
set hlsearch            " highlight search item
set incsearch           " move the matched pattern while entering
set ignorecase          " ignore the case while searching

" File format and encodings
set fileformats=dos,mac,unix
set fileencodings=utf-8,big5
set termencoding=utf-8
set encoding=utf-8

" Swap and backup file
if has("win32") 
    set directory=c:\\tmp,c:\\temp 
    set backupdir=c:\\tmp,c:\\temp 
elseif has("unix") 
    set directory=/tmp 
    set backupdir=/tmp 
endif

" Key mapping
imap <C-k> <up> 
imap <C-j> <down>
imap <C-h> <left>
imap <C-l> <right>
map  <C-k> Hjzz
map  <C-j> Lkzz
map  <C-n> :tabnew<CR>
map  <C-h> :tabprevious<CR>
map  <C-l> :tabnext<CR>
map  <C-c> :nohl<CR>
nmap ; :
vmap ; :
nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv
" Ctrl-p: toggle the paste mode
map <C-p> :set paste!<CR>
map <space> /


" Plugin settings
" Tagbar
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
map <C-o> :TagbarToggle<CR>

" Lightline
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

" GitGutter
highlight clear SignColumn
let g:gitgutter_sign_column_always = 1
