return {
    -- Your custom nvim-cmp style mappings
    snippets = {
        preset = 'luasnip',
    },
    appearance = { nerd_font_variant = 'normal' },
    completion = {
        keyword = {
            range = 'full',
        },
        list = { selection = { preselect = true, auto_insert = false } },
        documentation = {
            draw = function(opts)
                if opts.item and opts.item.documentation and opts.item.documentation.value then
                    local out = require('pretty_hover.parser').parse(opts.item.documentation.value)
                    opts.item.documentation.value = out:string()
                end

                opts.default_implementation(opts)
            end,
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
                border = 'rounded',
                max_width = 80,
            },
        },
        ghost_text = { enabled = true },
        accept = {
            auto_brackets = { enabled = true },
        },
        menu = require('nvchad.blink').menu,
    },
    fuzzy = {
        frecency = {
            enabled = true,
            path = vim.fn.stdpath 'state' .. '/blink/cmp/frecency.dat',
        },
        implementation = 'rust',
        sorts = {
            'exact',
            'sort_text',
            'score',
            'kind',
        },
    },
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
        ['<A-k>'] = { 'snippet_forward', 'fallback' },
        ['<A-j>'] = { 'snippet_backward', 'fallback' },
    },

    cmdline = {
        enabled = true,
        keymap = {
            preset = 'none',
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<Tab>'] = { 'show_and_insert', 'select_next', 'fallback' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<ESC>'] = { 'hide', 'fallback' },
            ['<C-y>'] = { 'accept', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback' },
            ['<C-n>'] = { 'select_next', 'fallback' },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        },
        completion = {
            list = {
                selection = {
                    preselect = true,
                    auto_insert = false,
                },
            },
            ghost_text = {
                enabled = true,
            },
            menu = { auto_show = true },
        },
        sources = function()
            local type = vim.fn.getcmdtype()
            -- Search forward and backward
            if type == '/' or type == '?' then
                return { 'buffer' }
            end
            -- Commands
            if type == ':' then
                return { 'cmdline' }
            end
            return {}
        end,
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
        providers = {
            snippets = {
                min_keyword_length = 1,
                score_offset = 10,
            },
            lsp = {
                min_keyword_length = 1,
                score_offset = 3,
            },
            path = {
                min_keyword_length = 2,
                score_offset = 2,
            },
            buffer = {
                min_keyword_length = 4,
                score_offset = 1,
            },
            lazydev = { module = 'lazydev.integrations.blink', score_offset = 5 },
        },
    },
}
