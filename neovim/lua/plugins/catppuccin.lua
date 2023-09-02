return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            transparent_background = vim.g.transparent_enabled
        })
        vim.cmd.colorscheme("catppuccin-macchiato")
    end,
}
