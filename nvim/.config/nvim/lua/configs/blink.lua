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
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = 'rounded' },
        },
        ghost_text = { enabled = true },
        accept = {
            auto_brackets = { enabled = true },
        },
        menu = require('nvchad.blink').menu,
    },
    fuzzy = {
        implementation = 'prefer_rust_with_warning',
        sorts = {
            'score',
            'sort_text',
            'label',
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
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
        providers = {
            snippets = {
                min_keyword_length = 1,
                score_offset = 4,
            },
            lsp = {
                min_keyword_length = 2,
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
