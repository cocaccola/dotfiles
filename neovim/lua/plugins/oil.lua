-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
    local dir = require("oil").get_current_dir()
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

return {
    'stevearc/oil.nvim',
    config = function()
        local detail = false
        require("oil").setup({
            skip_confirm_for_simple_edit = true,
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["<C-k>"] = false,
                ["<C-j>"] = false,
                ["gd"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        detail = not detail
                        if detail then
                            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,
                },
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, bufnr)
                    return name == ".." or
                        name == ".git" or
                        name == ".bare" or
                        name == ".DS_Store"
                end,
            },
            win_options = {
                winbar = "%!v:lua.get_oil_winbar()",
            },
        })

        vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
