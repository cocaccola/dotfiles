return {
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- Autocompletion
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'L3MON4D3/LuaSnip',
        },

        version = '1.*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'none',

                ['<M-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },

                ['<Tab>'] = { 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'show', 'fallback_to_mappings' },
                ['<C-n>'] = { 'select_next', 'show', 'fallback_to_mappings' },

                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

                ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            },

            snippets = { preset = 'luasnip' },

            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 100,
                },
                list = {
                    selection = { preselect = true, auto_insert = true }
                },
                ghost_text = {
                    enabled = true,
                },
                accept = { auto_brackets = { enabled = true }, },
                menu = {
                    draw = {
                        columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', gap = 1, 'kind' }, { 'source_name' } },
                        treesitter = { 'lsp' },
                    },
                },
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            signature = { enabled = true },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'mason-org/mason.nvim' },
            { 'mason-org/mason-lspconfig.nvim' },
        },
        config = function()
            vim.opt.signcolumn = 'yes'

            -- lsp_attach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover({border = "rounded"})<cr>', opts)
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
                                local unwanted_patterns = {
                                    "Browse gopls feature documentation",
                                    "Browse amd64 assembly for",
                                    "Browse arm64 assembly for"
                                }

                                for _, pattern in ipairs(unwanted_patterns) do
                                    if action.title:match(pattern) then
                                        return false
                                    end
                                end

                                return true
                            end,
                            apply = false,
                        })
                    end, { buffer = true, desc = "[C]ode [A]ction" })
                end,
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
                    border = 'rounded',
                    source = true,
                    header = '',
                    prefix = '',
                },
            })

            require("mason").setup()
            require('mason-lspconfig').setup()
        end
    }
}
