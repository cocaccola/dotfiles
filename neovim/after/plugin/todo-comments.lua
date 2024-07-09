-- todo comments keymaps
vim.keymap.set('n', '<leader>tt', vim.cmd.TodoTelescope, { desc = "[t]odo [t]elescope" })
vim.keymap.set('n', '<leader>tr', vim.cmd.TodoTrouble, { desc = "[t]odo t[r]ouble" })
vim.keymap.set('n', '<leader>tq', vim.cmd.TodoQuickfix, { desc = "[t]odo [q]uickfix" })
