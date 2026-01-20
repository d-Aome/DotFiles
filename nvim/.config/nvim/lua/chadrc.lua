-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "chadracula-evondev",

    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
        Normal = {
            bg = "NONE",
        },
    },
}
M.colorify = {
    enabled = true,
}
M.nvdash = { load_on_startup = true }
M.plugins = {}
M.ui = {
    tabufline = {
        enabled = false,
    },
    telescope = {
        style = "bordered",
    },
    cmp = {
        style = "default",
        icons_left = true,
        icons = true,
        format_colors = {
            lsp = true,
            icon = "icons_left",
        },
    },
    statusline = {
        separator_style = "default",
        theme = "vscode_colored",
    },
}
M.lsp = {
    signature = true,
}
return M
