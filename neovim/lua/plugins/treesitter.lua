return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "typescript",
                "awk",
                "bash",
                "comment",
                "diff",
                "go",
                "hcl",
                "json",
                "proto",
                "dockerfile",
                "yaml",
                "python",
                "ocaml",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                -- see: https://github.com/catppuccin/nvim#wrong-treesitter-highlights
                additional_vim_regex_highlighting = false
            },
            indent = {
                enable = true,
                disable = { "ocaml" }
            },
        })
    end,
}
