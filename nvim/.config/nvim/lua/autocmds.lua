require 'nvchad.autocmds'

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help', 'man', 'markdown', 'text' },
    group = vim.api.nvim_create_augroup('OpaqueManHelp', { clear = true }),
    callback = function()
        -- 1. Disable pseudo-transparency (for floating windows)
        vim.opt_local.winblend = 0

        -- 2. Force a background color
        -- If your theme clears the background, this maps the local 'Normal'
        -- group to 'NormalFloat' (which usually retains a background color).
        -- You can also change 'NormalFloat' to 'Pmenu' or 'StatusLine' if preferred.
        vim.opt_local.winhighlight = 'Normal:NormalFloat'
    end,
})

-- lua/init.lua

vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
    callback = function()
        -- Force a redraw of the statusline immediately
        vim.cmd 'redrawstatus'
    end,
})

vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]

vim.diagnostic.config {
    -- This is the magic line that allows errors to show up without pressing Esc
    update_in_insert = true,
    virtual_text = true,
}
