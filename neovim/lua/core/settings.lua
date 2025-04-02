-- NOTE: this currently breaks several plugins
-- https://github.com/nvim-lua/plenary.nvim/pull/649
-- https://github.com/nvim-telescope/telescope.nvim/issues/3436
-- https://github.com/hrsh7th/nvim-cmp/pull/2150
-- this has been worked around by setting the border on the call to
-- vim.lsp.buf.hover() for 'K'
-- https://neovim.io/doc/user/lsp.html#vim.lsp.util.open_floating_preview.Opts
-- vim.o.winborder = 'rounded'

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

-- https://neovim.io/doc/user/options.html#'tabstop'
-- by default, tab characters will be displayed natively if present
vim.o.tabstop = 8

-- we will use, by default, 4 spaces when pressing the tab key
-- we use ftplugin to configure per filetype settings
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
vim.g.netrw_list_hide = [[^\./$,^\.\./$,^\.git/$,^\.git$,^\.bare/$,\.DS_Store$]]
vim.g.netrw_hide = 1
vim.g.netrw_liststyle = 0

vim.o.signcolumn = 'yes'

vim.o.spelllang = 'en_us'
vim.o.spell = true

-- vim tries to do the correct thing, but for certain files this causes issues
vim.o.fixeol = false

-- clipboard
-- can also use: vim.loop.os_uname().sysname
if (jit.os == "Linux" and os.getenv("WSL_DISTRO_NAME") ~= nil) then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = false
    }
end
