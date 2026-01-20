-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "chadracula-evondev",
    transparency = false,
    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
        Normal = { bg = "NONE" }, -- The main text window
        NormalNC = { bg = "NONE" }, -- "Non-Current" windows (splits that aren't active)

        -- 3. Clean up the "Gutter" (where line numbers live)
        -- If you don't do this, line numbers will have a solid background block
        SignColumn = { bg = "NONE" },

        -- 4. (Optional) Clean up other main-editor elements to match transparency
        EndOfBuffer = { bg = "NONE" }, -- The tildes (~) at the end of the file
        Folded = { bg = "NONE" }, -- Folded code blocks        FloatBorder = {
        bg = "black",

        BlinkCmpMenu = { bg = "black", fg = "white" },
        BlinkCmpMenuBorder = {
            bg = "black",
        },
        BlinkCmpDoc = { bg = "#1e222a" },
        BlinkCmpDocBorder = { fg = "#56b6c2", bg = "#1e222a" },
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
