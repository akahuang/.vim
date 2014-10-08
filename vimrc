" Vundle
filetype on                    " let git amend not to error
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
let g:vundle_default_git_proto='git'

" let Vundle manage Vundle
Bundle 'gmarik/vundle'
" My Bundles here:
Bundle 'kevinw/pyflakes-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'msanders/snipmate.vim'
Bundle 'itchyny/lightline.vim'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neomru.vim'
Bundle 'Shougo/unite-outline'

" Enable filetype and syntax
syntax on               " enable syntax
filetype on             " enable filetype detection
filetype indent on      " enable filetype-specific indenting
filetype plugin on      " enable filetype-specific plugins
colorscheme darkblue

" Auto-completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
set completeopt=longest,menu

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
set fileformats=unix,dos,mac
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

" Display unwanted charactors
set list listchars=tab:_
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen ctermfg=white
call matchadd('ExtraWhitespace', '\s\+$')

" Key mapping
imap <C-k> <up>
imap <C-j> <down>
imap <C-h> <left>
imap <C-l> <right>
nnoremap  <C-k> Hjzz
nnoremap  <C-j> Lkzz
nnoremap  <C-n> :tabnew<CR>
nnoremap  <C-h> :tabprevious<CR>
nnoremap  <C-l> :tabnext<CR>
nnoremap  <C-c> :nohl<CR>
nnoremap ; :
vmap ; :
nnoremap <tab> v>
nnoremap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" Ctrl-p: toggle the paste mode
map <C-p> :set paste!<CR>

" Don't move on *
nnoremap * *<c-o>
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv
" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $

" Plugin settings
" Lightline
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
let g:Powerline_symbols = 'fancy'

" GitGutter
highlight clear SignColumn
let g:gitgutter_sign_column_always = 1

" markdown
autocmd BufReadPost,BufNewFile *.md set filetype=markdown

" Add python header
function PyHeader()
    if getfsize(@%) <= 0
        execute "norm i#!/usr/bin/env python# -*- coding: utf-8 -*-"
    endif
endfunction

au BufRead,BufNewFile *.py call PyHeader()

" Unite
let g:unite_source_history_yank_enable = 1
let g:unite_kind_file_vertical_preview = 0
let g:unite_split_rule = 'belowright'
" call unite#custom#profile('default', 'context', {'direction': 'botright'})

nnoremap <space>f :Unite -no-split -start-insert -buffer-name=files -prompt-direction=top file<CR>
nnoremap <space>b :Unite -no-split -auto-preview -buffer-name=buffer buffer<CR>
nnoremap <space>o :Unite -no-split -auto-preview -buffer-name=files  file_mru<CR>
nnoremap <space><space> :Unite -no-split -start-insert -buffer-name=all -prompt-direction=top file buffer file_mru<CR>
nnoremap <space>t :Unite -toggle -default-action=persist_open -vertical -winwidth=30 -buffer-name=outline outline<CR>
nnoremap <space>y :Unite history/yank<CR>
nnoremap <space>r :UniteResume<CR>
nnoremap <space>/ :Unite -start-insert line<CR>
nnoremap <space>* :UniteWithCursorWord line<CR>


" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

