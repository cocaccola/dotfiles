vim.api.nvim_create_user_command(
    'Doff',
    function(opts)
        if opts.bang then
            vim.cmd('windo diffoff!')
        else
            vim.cmd('windo diffoff')
        end
    end,
    {
        bang = true,
        desc = 'Turn off diff in all windows (use ! to force)'
    }
)
