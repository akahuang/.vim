" Vundle
filetype on                    " let git amend not to error
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
let g:vundle_default_git_proto='git'

" let Vundle manage Vundle
Bundle 'gmarik/vundle'
" My Bundles here:
Bundle 'scrooloose/syntastic'
Bundle 'Valloric/YouCompleteMe'
" Bundle 'msanders/snipmate.vim' TODO: change to UltiSnips
Bundle 'itchyny/lightline.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neomru.vim'
Bundle 'Shougo/unite-outline'
Bundle 'mileszs/ack.vim'
Bundle 'Yggdroot/indentLine'
Bundle 'mhinz/vim-startify'

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
set clipboard=unnamed   " bind system clipboard

" Indent settings
set shiftwidth=2        " indent size is 4
set softtabstop=2       " use 4 space to replace one tab
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
nnoremap  <C-n> :tabnew<CR>:Startify<CR>
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
cnoremap sudow w !sudo tee % >/dev/null

" Plugin settings
" Lightline
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['filename'],
      \   ],
      \   'right': [
      \     ['lineinfo', 'syntastic'],
      \     ['filetype', 'percent'],
      \     ['pwd', 'charcode', 'fileformat', 'fileencoding'],
      \   ]
      \ },
      \ 'component_function': {
      \   'modified'    : 'MyModified',
      \   'filename'    : 'MyFilename',
      \   'filetype'    : 'MyFiletype',
      \   'fileformat'  : 'MyFileformat',
      \   'fileencoding': 'MyFileencoding',
      \   'mode'        : 'MyMode',
      \   'pwd'         : 'MyPwd',
      \ },
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|'}
      \ }
let g:Powerline_symbols = 'fancy'

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? 'RO' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'unite' ? unite#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyMode()
  return  &ft == 'unite' ? 'Unite' : lightline#mode()
endfunction

function! MyFiletype()
  return winwidth(0) < 50 ? '' : (strlen(&filetype) ? &filetype : 'no ft')
endfunction

function! MyFileformat()
  return winwidth(0) < 70 ? '' : &fileformat
endfunction

function! MyFileencoding()
  return winwidth(0) < 70 ? '' : (strlen(&fenc) ? &fenc : &enc)
endfunction

function! MyPwd()
    return '' " winwidth(0) < 100 ? '' : substitute(getcwd(), $HOME, '~', 'g')
endfunction

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
nnoremap <space>F :Unite -no-split -start-insert -buffer-name=files -prompt-direction=top file_rec<CR>
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

" Syntastic setting
let g:syntastic_check_on_open=1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_python_checkers = ["pyflakes"]
let g:syntastic_python_flake8_args="--max-line-length=120"

" for ycm
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}
nnoremap <space>[ :YcmCompleter GoTo<CR>


" Google Setting
" source /usr/share/vim/google/google.vim
" Glug syntastic-google checkers=`{'python': 'gpylint'}`
" let g:syntastic_mode_map = {'mode': 'passive'}

hi StartifyBracket ctermfg=240
hi StartifyHeader  ctermfg=203
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240
let g:startify_custom_header = [
            \ '   __      ___            ______ ____',
            \ '   \ \    / (_)           |____  |___ \',
            \ '    \ \  / / _ _ __ ___       / /  __) |',
            \ '     \ \/ / | | ''_ ` _ \     / /  |__ <',
            \ '      \  /  | | | | | | |   / /   ___) |',
            \ '       \/   |_|_| |_| |_|  /_(_) |____/',
            \ '',
            \ '',
            \ ]
