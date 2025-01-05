return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { "rafamadriz/friendly-snippets" },
        },
        config = function()
            local cmp = require('cmp')

            local cmp_action = require('lsp-zero').cmp_action()
            local cmp_format = require('lsp-zero').cmp_format({ details = true })

            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path',    option = { trailing_slash = true } },
                    { name = 'buffer' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = vim.NIL,
                    ['<S-Tab>'] = vim.NIL,
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                formatting = cmp_format,
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            -- lsp_attach is where you enable features that only work
            -- if there is a language server active in the file
            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr }

                lsp_zero.default_keymaps({
                    buffer = bufnr,
                    preserve_mappings = false,
                })

                lsp_zero.buffer_autoformat()

                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

                vim.keymap.set('n', '<leader>st', '<cmd>lua vim.lsp.buf.document_symbol()<cr>',
                    { buffer = true, desc = "[S]ymbol [T]able of Contents" })
                vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>',
                    { buffer = true, desc = "[R]e [N]ame using lsp" })
                vim.keymap.set({ 'n', 'x' }, '<leader>fm', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                    { buffer = true, desc = "[F]or[M]at using lsp" })
                vim.keymap.set('n', '<leader>ca', function()
                    vim.lsp.buf.code_action({
                        filter = function(action)
                            local unwanted_actions = {
                                "Browse gopls feature documentation",
                                "Browse amd64 assembly for",
                                "Browse documentation for package"
                            }

                            for _, pattern in ipairs(unwanted_actions) do
                                if action.title:match(pattern) then
                                    return false
                                end
                            end

                            return true
                        end,
                        apply = false,
                    })
                end, { buffer = true, desc = "[C]ode [A]ction" })
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            })

            vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

            -- https://neovim.io/doc/user/diagnostic.html#diagnostic-severity
            vim.diagnostic.config({
                virtual_text = {
                    severity = {
                        min = vim.diagnostic.severity.INFO,
                    },
                },
                severity_sort = true,
                float = {
                    style = 'minimal',
                    border = 'none',
                    source = true,
                    header = '',
                    prefix = '',
                },
            })

            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                }
            })
        end
    }
}
