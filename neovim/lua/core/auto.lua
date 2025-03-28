local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- remove trailing whitespace
autocmd('BufWritePre', {
    pattern = '*',
    command = [[%s/\s\+$//e]],
    group = augroup('WhiteSpace', { clear = true }),
})

-- Highlight on yank
autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = augroup('YankHighlight', { clear = true }),
    pattern = '*',
})

-- Disable spellcheck in man pages
autocmd('FileType', {
    pattern = "man",
    callback = function()
        vim.opt_local.spell = false
    end,
})

-- Autoformat
-- source: https://lsp-zero.netlify.app/docs/language-server-configuration.html#enable-format-on-save
local buffer_autoformat = function(bufnr)
    local group = 'lsp_autoformat'
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        group = group,
        desc = 'LSP format on save',
        callback = function()
            -- note: do not enable async formatting
            vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end,
    })
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local id = vim.tbl_get(event, 'data', 'client_id')
        local client = id and vim.lsp.get_client_by_id(id)
        if client == nil then
            return
        end

        -- make sure there is at least one client with formatting capabilities
        if client.supports_method('textDocument/formatting') then
            buffer_autoformat(event.buf)
        end
    end
})
