require "nvchad.autocmds"

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help", "man" },
    group = vim.api.nvim_create_augroup("OpaqueManHelp", { clear = true }),
    callback = function()
        -- 1. Disable pseudo-transparency (for floating windows)
        vim.opt_local.winblend = 0

        -- 2. Force a background color
        -- If your theme clears the background, this maps the local 'Normal'
        -- group to 'NormalFloat' (which usually retains a background color).
        -- You can also change 'NormalFloat' to 'Pmenu' or 'StatusLine' if preferred.
        vim.opt_local.winhighlight = "Normal:NormalFloat"
    end,
})
