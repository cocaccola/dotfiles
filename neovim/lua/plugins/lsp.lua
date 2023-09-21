return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
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
        local lsp = require('lsp-zero')

        lsp.on_attach(function(_, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp.default_keymaps({
                buffer = bufnr,
                preserve_mappings = false,
            })
            -- see https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/lsp.md#enable-format-on-save
            lsp.buffer_autoformat()

            vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>',
                { buffer = true, desc = "[R]e [N]ame using lsp" })
            vim.keymap.set({ 'n', 'x' }, '<leader>fm', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                { buffer = true, desc = "[F]or[M]at using lsp" })
            vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>',
                { buffer = true, desc = "[C]ode [A]ction" })
        end)

        -- (Optional) Configure lua language server for neovim
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { 'tsserver', 'rust_analyzer' },
            handlers = {
                lsp.default_setup,
                lua_ls = function()
                    local lua_opts = lsp.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            }
        })


        lsp.setup()

        local cmp = require('cmp')
        local cmp_format = require('lsp-zero').cmp_format()
        -- local cmp_action = require('lsp-zero').cmp_action()
        cmp.setup({
            formatting = cmp_format,
            mapping = cmp.mapping.preset.insert({
                -- attempt to disable tab for cmp
                ['<Tab>'] = vim.NIL,
                ['<S-Tab>'] = vim.NIL,
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                -- super tab, this might be bugged
                -- ['<Tab>'] = cmp_action.luasnip_supertab(),
                -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                -- try regular tab completion
                -- ['<Tab>'] = cmp_action.tab_complete(),
                -- ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
                -- manually open menu
                -- ['<C-Space>'] = cmp.mapping.complete()
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })
        })
    end,
}
