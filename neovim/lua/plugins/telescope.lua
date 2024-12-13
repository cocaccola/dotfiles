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
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-tree/nvim-web-devicons',            enabled = true },
    },
    config = function()
        require('telescope').setup({
            defaults = {},
            pickers = {
                buffers = {
                    ignore_current_buffer = false,
                    sort_lastused = true,
                    sort_mru = true,
                },
                find_files = {
                    find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
                },
                live_grep = {
                    additional_args = { "--hidden" }
                },
                planets = {
                    show_pluto = true,
                    show_moon = true,
                },
            },
            extensions = {
                fzf = {},
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        })
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

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

        vim.keymap.set('n', '<leader>ad', builtin.diagnostics, { desc = 'Show [A]ll [D]iagnostics' })

        vim.keymap.set('n', '<leader>sd', function()
            builtin.diagnostics({
                bufnr = 0,
                severity_limit = "Error",
            })
        end, { desc = '[S]how [D]iagnostics (current buffer, Error and above)' })

        vim.keymap.set('n', '<leader>ed', function()
            builtin.diagnostics({ severity_limit = "Error" })
        end, { desc = 'Show [E]rror [D]iagnostics (all buffers, Error and above)' })


        vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = '[S]earch [S]ymbols' })
        vim.keymap.set('n', '<leader>sw', builtin.lsp_workspace_symbols, { desc = '[S]ymbols in [W]orkspace' })
        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = '[F]ind [R]eferences' })
        vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, { desc = '[F]ind [I]mplementations' })
        vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, { desc = '[F]ind [D]definitions' })
        vim.keymap.set('n', '<leader>td', builtin.lsp_type_definitions, { desc = '[T]ype [D]efinitions' })

        vim.keymap.set('n', '<leader>ft', builtin.filetypes, { desc = '[F]ile [T]ypes' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
        vim.keymap.set('n', '<leader>jl', builtin.jumplist, { desc = '[J]ump [L]ist' })
        vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })

        vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })

        vim.keymap.set('n', '<leader>tp', builtin.planets, { desc = '[T]elescope [P]lanets' })
    end,
}
