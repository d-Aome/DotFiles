return {
    {
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
            -- Snippet Engine
            {
                'L3MON4D3/LuaSnip',
                version = '2.*',
                build = (function()
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    'rafamadriz/friendly-snippets',
                },
            },
            'folke/lazydev.nvim',
        },
        opts = {
            -- Your custom nvim-cmp style mappings
            keymap = {
                preset = 'none',
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<ESC>'] = { 'hide', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
                -- LuaSnip jumps
                ['<C-k>'] = { function(cmp) if cmp.snippet_active() then return cmp.snippet_forward() end end, 'fallback' },
                ['<C-j>'] = { function(cmp) if cmp.snippet_active() then return cmp.snippet_backward() end end, 'fallback' },
            },

            appearance = {
                nerd_font_variant = 'mono',
            },

            completion = {
                list = { selection = { preselect = true, auto_insert = false } },
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
                ghost_text = { enabled = true },
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
                providers = {
                    lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                },
            },

            snippets = { preset = 'luasnip' },
            signature = { enabled = true },
        },
    },
}
