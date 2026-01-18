-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
                            group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
                            callback = function()
                            vim.hl.on_yank()
                            end,
})

-- =============================================================================
-- 4. Autocommands (Quiet Substitute)
-- =============================================================================

vim.api.nvim_create_autocmd("CmdlineLeave", {
    group = vim.api.nvim_create_augroup("QuietSubstitute", { clear = true }),
                            callback = function()
                            local cmd = vim.fn.getcmdline()
                            if cmd:match("s/") or cmd:match("^%%s") then
                                vim.schedule(function()
                                vim.cmd("nohlsearch")
                                end)
                                end
                                end,
})
