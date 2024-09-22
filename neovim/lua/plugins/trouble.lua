return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xb",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xl",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>qf",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
    config = function()
        local opts = {}
        require("trouble").setup(opts)
        vim.keymap.set("n", "<M-n>", function()
            require("trouble").next({})
            require("trouble").jump({})
        end, { desc = "Trouble next item" })

        vim.keymap.set("n", "<M-p>", function()
            require("trouble").prev({})
            require("trouble").jump({})
        end, { desc = "Trouble prev item" })

        vim.keymap.set("n", "<leader>xc", function()
            require("trouble").close({})
        end, { desc = "close Trouble" })
    end,
}
