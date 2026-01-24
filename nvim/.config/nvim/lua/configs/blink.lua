return {
    -- Your custom nvim-cmp style mappings
    snippets = { preset = "luasnip" },
    documentation = {
        draw = function(opts)
            if opts.item and opts.item.documentation and opts.item.documentation.value then
                local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
                opts.item.documentation.value = out:string()
            end

            opts.default_implementation(opts)
        end,
    },
    appearance = { nerd_font_variant = "normal" },
    completion = {
        list = { selection = { preselect = true, auto_insert = false } },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = "single" },
        },
        ghost_text = { enabled = true },
        accept = {
            auto_brackets = { enabled = true },
            textEdit = true,
        },
        menu = require("nvchad.blink").menu,
    },
    keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<ESC>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        -- LuaSnip jumps
        ["<A-k>"] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.snippet_forward()
                end
            end,
            "fallback",
        },
        ["<A-j>"] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.snippet_backward()
                end
            end,
            "fallback",
        },
    },

    cmdline = {
        enabled = true,
        keymap = {
            preset = "none",
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<Tab>"] = { "show_and_insert", "select_next", "fallback" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<ESC>"] = { "hide", "fallback" },
            ["<C-y>"] = { "accept", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
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
        default = { "lsp", "path", "snippets", "lazydev", "buffer" },
        providers = {
            lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        },
    },
}
