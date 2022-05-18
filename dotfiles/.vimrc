syntax on
colo ron
map <space> <leader>
map <leader>f :!./%<cr>
map <leader>d :!clear<cr><cr>
map <leader>a :!chmod +x %<cr>
map <leader>n :noh<cr>
map <C-c> i#!/usr/bin/env python3<esc>o
inoremap <C-c> ()<esc>i
inoremap jk <esc>
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <leader>h 10<C-W><
nnoremap <leader>j 10<C-W>+
nnoremap <leader>k 10<C-W>-
nnoremap <leader>l 10<C-W>>
nnoremap <leader>= <C-W>=
nnoremap <leader>v <C-W>|
nnoremap <leader>s <C-W>_
nnoremap <leader>r <C-W>R
nnoremap <leader>t <C-W>T
nnoremap <leader>o <C-W>o
nnoremap <leader>q :qa<CR>
nnoremap <leader>w :q!<CR>
nnoremap <leader>e :xa<CR>
nnoremap <leader>p :set invpaste paste?<CR>
set pastetoggle=<leader>p
set modeline
set report=0
set list
set listchars=tab:»•,trail:¬
set timeoutlen=250
set smartindent
set tabstop=4
set shiftwidth=4
set shiftround
set softtabstop=4
set expandtab
set number
set relativenumber
set showcmd
set title
set cursorline
set backspace=2
set autoread
set breakindent
set copyindent
set showmatch
set wildmenu
set wildmode=longest:full,full
set laststatus=2
set ruler
set hlsearch
set incsearch
set colorcolumn=100
set splitbelow
set splitright
set fillchars=stl:-,stlnc:-,vert:│
set nofixendofline
filetype plugin indent on
hi TabLine      ctermfg=White     ctermbg=DarkGray     cterm=NONE
hi TabLineFill  ctermfg=White     ctermbg=Black        cterm=NONE
hi TabLineSel   ctermfg=LightGray ctermbg=DarkMagenta  cterm=NONE
hi ColorColumn  ctermfg=Black     ctermbg=DarkGray     cterm=NONE
hi StatusLine   ctermfg=LightGray ctermbg=NONE         cterm=NONE
hi StatusLineNC ctermfg=LightGray ctermbg=NONE         cterm=NONE
hi WildMenu     ctermfg=Black     ctermbg=LightCyan    cterm=NONE
hi VertSplit    ctermfg=LightGray ctermbg=NONE         cterm=NONE
hi Search       ctermfg=Black     ctermbg=LightMagenta cterm=NONE
