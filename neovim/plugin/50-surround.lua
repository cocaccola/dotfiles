vim.pack.add({ { src = "https://github.com/nvim-mini/mini.surround" } })

require('mini.surround').setup({
    n_lines = 100,
    search_method = 'cover_or_next',
})
