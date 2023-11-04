return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },
    config = function()
        require('telescope').setup({
            defaults = {
                mappings = {
                    -- these were suggested by kickstart
                    -- disable if you don't like them
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
            },
            pickers = {
                buffers = {
                    ignore_current_buffer = true,
                    sort_lastused = true,
                    sort_mru = true,
                },
                current_buffer_fuzzy_find = {

                },
                find_files = {
                    find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
                },
            },
        })
        pcall(require('telescope').load_extension, 'fzf')

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find,
            { desc = '[/] Fuzzily search in current buffer' })
        vim.keymap.set('n', '<leader>of', require('telescope.builtin').oldfiles,
            { desc = 'Find recently [O]pened [F]iles' })

        vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })

        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]how [D]iagnostics' })
        vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = '[S]earch [S]ymbols' })
        vim.keymap.set('n', '<leader>ws', builtin.lsp_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })
        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = '[F]ind [R]eferences' })
        vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, { desc = '[F]ind [I]mplementations' })
        vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, { desc = '[F]ind [D]definitions' })
        vim.keymap.set('n', '<leader>td', builtin.lsp_type_definitions, { desc = '[T]ype [D]efinitions' })

        vim.keymap.set('n', '<leader>ft', builtin.filetypes, { desc = '[F]ile [T]ypes' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
        vim.keymap.set('n', '<leader>jl', builtin.jumplist, { desc = '[J]ump [L]ist' })
    end,
}
