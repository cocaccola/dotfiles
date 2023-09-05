vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.o.backup = false
vim.o.swapfile = false

vim.o.termguicolors = true

vim.o.guicursor = ''
vim.o.cursorline = true
vim.o.cursorlineopt = 'line'

-- allows the '@' character to be used in filenames
vim.o.isfname = vim.o.isfname .. ',@-@'

vim.o.wrap = false

vim.o.scrolloff = 8

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.updatetime = 50

-- see https://neovim.io/doc/user/options.html#'timeoutlen'
-- need to find an optimal time, default is 1000
vim.o.timeoutlen = 500

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25
vim.g.netrw_list_hide = [[^\./$,^\.\./$,^\.git/$,^\.bare/$,\.DS_Store]]
vim.g.netrw_hide = 1
vim.g.netrw_liststyle = 0

vim.o.spell = true
