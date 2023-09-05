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

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { silent = true })

-- quick fix list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- close current buffer
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { silent = true })

-- register keymaps
-- tend to start with leader r

-- list
vim.keymap.set("n", "<leader>rl", vim.cmd.registers, { silent = true })

-- mark keymaps
-- tend to start with leader m

-- list marks
vim.keymap.set("n", "<leader>ml", vim.cmd.marks, { silent = true })
