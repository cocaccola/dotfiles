local actions = require("telescope.actions")
local telescope = require("telescope")

function open_qf_trouble(prompt_bufnr)
    -- Send selected items to the quickfix list
    actions.send_to_qflist(prompt_bufnr)
    -- Open Trouble in quickfix mode
    vim.cmd("Trouble qflist toggle")
end

telescope.setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = open_qf_trouble },
      n = { ["<c-t>"] = open_qf_trouble },
    },
  },
})
