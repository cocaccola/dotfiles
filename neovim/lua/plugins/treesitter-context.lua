return {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
        require('treesitter-context').setup()

        vim.keymap.set("n", "[c", function()
            require("treesitter-context").go_to_context()
        end, { silent = true })
    end,
}
