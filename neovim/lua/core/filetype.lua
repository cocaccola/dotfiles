vim.filetype.add({
    extension = {
        sh = function(path, bufnr)
            local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
            if first_line:match('#!.*bash') then
                return "bash"
            elseif first_line:match('#!.*zsh') then
                return "zsh"
            elseif first_line:match('#!.*dash') then
                return "dash"
            elseif first_line:match('#!.*ksh') then
                return "ksh"
            else
                return "sh"
            end
        end
    }
})
