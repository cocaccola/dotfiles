return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require("indent_blankline").setup {
            char = "▎",
            context_char = "▎",
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
            use_treesitter_scope = true,
        }
    end,
}
