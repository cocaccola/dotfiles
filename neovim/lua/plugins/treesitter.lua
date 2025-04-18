return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "javascript",
                    "typescript",
                    "awk",
                    "bash",
                    "comment",
                    "diff",
                    "go",
                    "hcl",
                    "json",
                    "proto",
                    "dockerfile",
                    "yaml",
                    "python",
                    "ocaml",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    -- see: https://github.com/catppuccin/nvim#wrong-treesitter-highlights
                    additional_vim_regex_highlighting = false
                },
                indent = {
                    enable = true,
                    disable = { "ocaml" }
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<c-backspace>',
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            'lewis6991/gitsigns.nvim',
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["ai"] = "@conditional.outer",
                            ["ii"] = "@conditional.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                            ["ab"] = "@block.outer",
                            ["ib"] = "@block.inner",
                            ["as"] = "@statement.outer",
                            ["is"] = "@statement.outer",
                            ["aC"] = "@comment.outer",
                            ["iC"] = "@comment.inner",
                            ["a="] = "@assignment.outer",
                            ["i="] = "@assignment.inner",
                            ["at"] = "@attribute.outer",
                            ["it"] = "@attribute.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                            ["]b"] = "@block.outer",
                            ["]a"] = "@parameter.inner",
                            ["]i"] = "@conditional.outer",
                            ["]l"] = "@loop.outer",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]C"] = "@class.outer",
                            ["]B"] = "@block.outer",
                            ["]A"] = "@parameter.outer",
                            ["]I"] = "@conditional.outer",
                            ["]L"] = "@loop.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                            ["[b"] = "@block.outer",
                            ["[a"] = "@parameter.inner",
                            ["[i"] = "@conditional.outer",
                            ["[l"] = "@loop.outer",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[C"] = "@class.outer",
                            ["[B"] = "@block.outer",
                            ["[A"] = "@parameter.outer",
                            ["[I"] = "@conditional.outer",
                            ["[L"] = "@loop.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                },
            })

            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

            -- Repeat movement with ; and ,
            -- ensure ; goes forward and , goes backward regardless of the last direction
            -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

            -- vim way: ; goes to the direction you were moving.
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

            -- example: make gitsigns.nvim movement repeatable with ; and , keys.
            local gs = require("gitsigns")

            -- make sure forward function comes first
            local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk,
                gs.prev_hunk)

            vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk_repeat)
            vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk_repeat)
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require('treesitter-context').setup()

            vim.keymap.set("n", "[[c", function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { silent = true })
        end,
    },
}
