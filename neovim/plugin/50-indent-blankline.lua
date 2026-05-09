vim.pack.add({
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim", name = "ibl" }
})

require("ibl").setup {
    indent = {
        char = "▎",
    },
    scope = {
        show_end = false,
    },
}

-- return {
--     "lukas-reineke/indent-blankline.nvim",
--     main = "ibl",
--     opts = {},
--     config = function()
--         require("ibl").setup {
--             indent = {
--                 char = "▎",
--             },
--             scope = {
--                 show_end = false,
--             },
--         }
--     end,
-- }
