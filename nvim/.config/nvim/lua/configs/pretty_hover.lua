return {
    -- 1. Appearance
    border = "rounded", -- Options: "single", "double", "rounded", "solid", "shadow"
    max_width = 80, -- Prevent the window from becoming too wide to read
    max_height = 20, -- Limit height to avoid covering the whole screen

    -- 2. Content Customization
    -- This helps remove or style the repetitive parts of LSP messages
    line = {
        styler = {
            -- Highlights specific keywords to make them pop
            "@param",
            "@return",
            "@throws",
            "@link",
        },
    },

    -- 3. Custom Colors (Optional but recommended)
    -- You can customize the colors of the highlighted keywords
    hl = {
        -- Example: Make errors bold red
        error = {
            color = "#ff5555",
            detect = { "Error", "error" },
        },
        -- Example: Make warnings orange
        warning = {
            color = "#ffb86c",
            detect = { "Warning", "warning" },
        },
        -- Example: Make info/notes blue
        info = {
            color = "#8be9fd",
            detect = { "Note", "note", "Info", "info" },
        },
    },
}
