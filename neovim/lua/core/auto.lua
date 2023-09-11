local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- remove trailing whitespace
autocmd('BufWritePre', {
    pattern = '*',
    command = [[%s/\s\+$//e]],
    group = augroup('WhiteSpace', { clear = true }),
})

-- Highlight on yank
autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = augroup('YankHighlight', { clear = true }),
    pattern = '*',
})
