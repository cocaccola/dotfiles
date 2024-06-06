return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('trouble').setup()
        vim.keymap.set("n", "<leader>xo", function() require("trouble").open() end, { desc = "Open Diagnostics" })
        vim.keymap.set("n", "<leader>xp", function() require("trouble").open("workspace_diagnostics") end,
            { desc = "Workspace (project) Diagnostics" })
        vim.keymap.set("n", "<leader>xx", function() require("trouble").open("document_diagnostics") end,
            { desc = "Document Diagnostics" })
        vim.keymap.set("n", "<leader>qf", function() require("trouble").open("quickfix") end, { desc = "Quick Fix" })
        vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end, { desc = "loclist" })
        vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end, { desc = "lsp references" })
        vim.keymap.set("n", "<leader>xc", function() require("trouble").close(opts) end, { desc = "close Trouble" })

        vim.keymap.set("n", "<C-j>", function()
            require("trouble").next(opts)
            require("trouble").jump(opts)
        end, { desc = "Trouble next item" })

        vim.keymap.set("n", "<C-k>", function()
            require("trouble").prev(opts)
            require("trouble").jump(opts)
        end, { desc = "Trouble prev item" })
    end,
}
