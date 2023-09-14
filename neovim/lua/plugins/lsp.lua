return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },             -- Required
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },     -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'L3MON4D3/LuaSnip' },     -- Required
    },
    config = function()
        local lsp = require('lsp-zero').preset({
            name = 'recommended'
        })

        lsp.on_attach(function(_, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp.default_keymaps({ buffer = bufnr })
            -- see https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#enable-format-on-save
            lsp.buffer_autoformat()

            vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>',
                { buffer = true, desc = "[R]e [N]ame using lsp" })
            vim.keymap.set({ 'n', 'x' }, '<leader>fm', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                { buffer = true, desc = "[F]or[M]at using lsp" })
            vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>',
                { buffer = true, desc = "[C]ode [A]ction" })
        end)

        -- (Optional) Configure lua language server for neovim
        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

        lsp.setup()

        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()
        cmp.setup({
            mapping = {
                -- ['<Tab>'] = cmp_action.luasnip_supertab(),
                -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                -- try regular tab completion
                ['<Tab>'] = cmp_action.tab_complete(),
                ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }
        })
    end,
}
