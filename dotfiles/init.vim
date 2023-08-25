map <space> <leader>
map <leader>n :noh<cr>
" these are broken in vscode neovim
" it might be fixed here: https://github.com/vscode-neovim/vscode-neovim/pull/1335
" https://github.com/vscode-neovim/vscode-neovim/issues/1261
" the below doesn't seem to work either
" when it's fixed we probably want to use 'zz' in place of 'M'
nnoremap <C-d> <C-d>M
nnoremap <C-u> <C-u>M
set incsearch
" we don't want this
"set hlsearch
" what we actually want is
set nohlsearch
" toggle highlight on or off, use to see what was searched for
nnoremap <C-h> :set hlsearch!<cr>
