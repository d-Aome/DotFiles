return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        local dashboard = require 'dashboard'
        local pokemon = require 'pokemon'
        pokemon.setup {
            number = '0006.3',
            size = 'large',
        }
        dashboard.setup {
            theme = 'doom', -- Ensure theme is set to hyper for this look
            shortcut_type = 'letter',
            config = {
                header = pokemon.header(),
                center = {
                    { icon = '  ', desc = 'FZF', key = 'fw', action = 'FzfLua' },
                    { icon = '  ', desc = 'Find Files', key = 'ff', action = 'FzfLua files' },
                    { icon = '󰒓  ', desc = 'Find Config', key = 'fn', action = 'FzfLua files cwd=' .. vim.fn.stdpath 'config' },
                    { icon = '  ', desc = 'Find Word', key = 'fr', action = 'FzfLua oldfiles' },
                    { icon = '  ', desc = 'Help', key = 'fh', action = 'FzfLua help_tags' },
                },
                -- ADD THIS SECTION BELOW:
                footer = {
                    ' ',
                    '────────────────────────────────────────────────',
                    '  CUSTOM MAPS',
                    '    Toggle Terminal (≈)',
                    '  󰊢  Open Git Status (g s)',
                    ' ',
                },
            },
        }
    end,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'ColaMint/pokemon.nvim',
    },
}
