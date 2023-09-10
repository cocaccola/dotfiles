return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('trouble').setup()
        vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
        vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
        vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
        vim.keymap.set("n", "<leader>qf", function() require("trouble").open("quickfix") end)
        vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
        vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)
    end,
}
