-- keyboard mappings
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('i', 'jk', '<Esc>', { silent = true })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- key cursor centered when scrolling up / down or
-- moving between search results
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- move lines of code around
-- see https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- securely delete using the black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- delete and paste over using select or visual mode
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { silent = true })

-- quick fix list
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<CR>zz", { desc = "[Q]uickfix [N]ext item" })
vim.keymap.set("n", "<leader>qp", "<cmd>cprev<CR>zz", { desc = "[Q]uickfix [P]rev item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- close current buffer
vim.keymap.set("n", "<leader>cc", vim.cmd.bdelete, { silent = true, desc = "[C]lose [C]urrent buffer" })

-- window prefix
vim.keymap.set({ "n", "t" }, "<leader>w", "<c-w>", { desc = "Window command prefix" })

-- macro keymaps
-- if in visual line mode, it will auto insert mark ranges '<,'>
vim.keymap.set("x", "<leader>ms", ":normal @", { desc = "[M]acro over [S]election" })


-- register keymaps
-- tend to start with leader r
--
-- a note about registers, you can use :wsh and :rsh to sync registers between nvim processes
-- see https://neovim.io/doc/user/starting.html#%3Arshada

-- list registers
-- types column guide
--
-- c – characterwise text
-- l – linewise text
-- b – blockwise text
vim.keymap.set("n", "<leader>rl", vim.cmd.registers, { silent = true, desc = "[R]egisters [L]ist" })

-- mark keymaps
-- tend to start with leader m

-- list marks
vim.keymap.set("n", "<leader>ml", vim.cmd.marks, { silent = true, desc = "[M]ark [L]ist" })

local global_marks = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
vim.keymap.set("n", "<leader>gm", "<cmd>marks " .. global_marks .. "<cr>", { silent = true, desc = "[G]lobal [M]arks" })

-- command line mode editing
vim.cmd('cnoremap <M-h> <Left>')
vim.cmd('cnoremap <M-l> <Right>')

-- new scratch buffer
vim.keymap.set("n", "<leader>n", vim.cmd.enew, { silent = true, desc = "[N]ew empty buffer" })

-- set filetype to zsh
vim.keymap.set("n", "<leader>sh", "<cmd>set filetype=zsh<cr>",
    { silent = true, desc = "Set filetype to shell (z[S][H])" })

-- vim split easy resize
vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>+")
vim.keymap.set("n", "<M-s>", "<C-W>-")
-- alternative idea
vim.keymap.set("n", "<M-=>", "<C-W>5+")
vim.keymap.set("n", "<M-->", "<C-W>5-")

-- -- easy split nav
vim.keymap.set("n", "<C-j>", "<c-w><c-j>")
vim.keymap.set("n", "<C-k>", "<c-w><c-k>")
vim.keymap.set("n", "<C-l>", "<c-w><c-l>")
vim.keymap.set("n", "<C-h>", "<c-w><c-h>")


-- Man pages

-- Notes:
-- Table of Contents | gO
-- https://neovim.io/doc/user/filetype.html#%3AMan
-- https://neovim.io/doc/user/various.html#gO
-- command in normal mode: gO (capital letter o)

-- default man command
vim.keymap.set("n", "<leader>mm", "<cmd>Man<cr>", { silent = true })

ManSections = {
    "User commands (Programs)",
    "System calls",
    "Library calls",
    "Special files (devices)",
    "File formats and configuration files",
    "Games",
    "Overview, conventions, and miscellaneous",
    "System management commands",
}

for section, desc in ipairs(ManSections) do
    vim.keymap.set("n", "<leader>m" .. section,
        function()
            return '<cmd>Man ' .. section .. ' ' .. vim.fn.expand('<cword>') .. '<cr>'
        end,
        { silent = true, expr = true, desc = "Man: " .. desc }
    )
end
