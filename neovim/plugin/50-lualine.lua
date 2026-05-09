vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim'
})

require('lualine').setup({
    options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = '|',
        section_separators = '',
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 1,
            }
        }
    }
})

