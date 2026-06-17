---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = 'horizon',
    transparency = false,
    hl_add = {
        LazyGitFloat = { bg = 'black' },
        LazyGitBorder = { bg = 'None' },
        PrettyHoverBorder = {
            fg = '#56b6c2',
            bg = '#1e222a',
        },
    },

    hl_override = {
        Comment = { italic = true },
        ['@comment'] = { italic = true },
        Normal = { bg = 'NONE' }, -- The main text window

        NormalNC = { bg = 'NONE' }, -- "Non-Current" windows (splits that aren't active)

        SignColumn = { bg = 'NONE' },

        EndOfBuffer = { bg = 'NONE' }, -- The tildes (~) at the end of the file
        Folded = { bg = 'NONE' }, -- Folded code blocks        FloatBorder = {

        BlinkCmpMenu = { bg = 'black', fg = 'white' },
        BlinkCmpMenuBorder = {
            bg = 'black',
        },

        BlinkCmpDoc = { bg = '#1e222a' },
        BlinkCmpDocBorder = { fg = '#56b6c2', bg = '#1e222a' },
        BlinkCmpSignatureHelp = { bg = 'black' },
        BlinkCmpSignatureHelpBorder = { fg = '#56b6c2', bg = 'black' },
    },
}

M.colorify = {
    enabled = true,
    mode = 'virtual',
}

M.nvdash = { load_on_startup = true }
M.ui = {
    tabufline = {
        enabled = false,
    },
    telescope = {
        style = 'bordered',
    },
    cmp = {
        style = 'default',
        icons_left = true,
        icons = true,
        format_colors = {
            lsp = true,
            icon = 'icons_left',
        },
    },
    statusline = {
        separator_style = 'default',
        modules = {
            macro = function()
                local recording_register = vim.fn.reg_recording()
                if recording_register == '' then
                    return ''
                else
                    -- Using %#{HighlightGroup}# syntax for colors.
                    -- "St_LspError" usually gives a nice red color suitable for recording.
                    return '%#St_LspError# 󰑋 Rec @' .. recording_register .. ' '
                end
            end,
        },
        theme = 'vscode_colored',

        order = {
            'mode',
            'file',
            'git',
            'macro',
            '%=',
            'lsp_msg',
            '%=',
            'diagnostics',
            'lsp',
            'cursor',
            'cwd',
        },
    },
}

M.lsp = {
    signature = false,
}

return M
