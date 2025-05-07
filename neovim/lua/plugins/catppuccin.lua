return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        local palette = require("catppuccin.palettes").get_palette("mocha")
        require('catppuccin').setup({
            transparent_background = vim.g.transparent_enabled,
            custom_highlights = {
                LineNr = { fg = palette.rosewater },
                GitSignsCurrentLineBlame = { fg = palette.surface2 },
            },
        })
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
}
