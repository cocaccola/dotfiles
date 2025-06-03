return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = 'main',
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.setup()

            local ensure_installed = {
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
                "markdown",
            }

            local _installed = ts.get_installed()
            local newly_installed = {}
            local to_install = vim.iter(ensure_installed):filter(
                function(parser)
                    if vim.tbl_contains(_installed, parser) then
                        return false
                    end
                    table.insert(newly_installed, parser)
                    return true
                end
            ):totable()

            ts.install(to_install)
            local installed = vim.tbl_extend('keep', _installed, newly_installed)

            vim.api.nvim_create_autocmd('FileType', {
                pattern = { '*' },
                callback = function(ctx)
                    if not vim.tbl_contains(installed, ctx.match) then
                        ts.install(ctx.match)
                    end

                    local highlights = pcall(vim.treesitter.start)

                    local disable_indent = {
                        'ocaml',
                    }
                    if highlights and not vim.tbl_contains(disable_indent, ctx.match) then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        branch = 'main',
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                },
                move = {
                    set_jumps = true,
                },
            })

            -- Selection keymaps
            vim.keymap.set({ "n", "x", "o" }, "af", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "if", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "ac", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "ic", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "aa", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "ia", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "ai", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "ii", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "al", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "il", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "ab", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "ib", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "as", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@statement.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "is", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@statement.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "aC", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@comment.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "iC", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@comment.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "a=", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@assignment.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "i=", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@assignment.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "at", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@attribute.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "it", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@attribute.inner", "textobjects")
            end)

            -- Movement keymaps - goto next start
            vim.keymap.set({ "n", "x", "o" }, "]f", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]c", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]b", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]a", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]i", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@conditional.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]l", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@loop.outer", "textobjects")
            end)

            -- Movement keymaps - goto next end
            vim.keymap.set({ "n", "x", "o" }, "]F", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]C", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]B", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]A", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]I", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@conditional.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]L", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@loop.outer", "textobjects")
            end)

            -- Movement keymaps - goto previous start
            vim.keymap.set({ "n", "x", "o" }, "[f", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[c", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[b", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[a", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[i", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@conditional.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[l", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@loop.outer", "textobjects")
            end)

            -- Movement keymaps - goto previous end
            vim.keymap.set({ "n", "x", "o" }, "[F", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[C", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[B", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[A", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[I", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@conditional.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[L", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@loop.outer", "textobjects")
            end)

            -- Swap keymaps
            vim.keymap.set("n", "<leader>a", function()
                require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
            end)
            vim.keymap.set("n", "<leader>A", function()
                require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
            end)

            local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

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
