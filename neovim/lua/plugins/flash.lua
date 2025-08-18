return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        modes = {
            search = {
                enabled = true
            },
            char = {
                -- TODO: this feature seems broken for 'f' motions
                -- https://github.com/folke/flash.nvim/issues/442
                enabled = false,
                jump_labels = true,
                label = { exclude = "hjkliardcsxyft" },
            }
        }
    },
    -- stylua: ignore
    keys = {
        { "<leader>zz", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "<leader>zx", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",          mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",          mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
}
