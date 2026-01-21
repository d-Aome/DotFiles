return {
    -- 1. Appearance
    border = "rounded", -- Options: "single", "double", "rounded", "solid", "shadow"
    max_width = 80, -- Prevent the window from becoming too wide to read
    max_height = 20, -- Limit height to avoid covering the whole screen
    header = {
        detect = { "[\\@]class" },
        styler = "###",
    },
    listing = {
        detect = { "[\\@]li" },
        styler = " - ",
    },
    -- 2. Content Customization
    line = {

        detect = { "[\\@]brief" },
        styler = "**",
    },
    references = {
        detect = { "[\\@]ref", "[\\@]c", "[\\@]name" },
        styler = { "**", "`" },
    },
    group = {
        detect = {
            -- ["Group name"] = {"detectors"}
            ["Parameters"] = { "[\\@]param", "[\\@]*param*" },
            ["Types"] = { "[\\@]tparam" },
            ["See"] = { "[\\@]see" },
            ["Return Value"] = { "[\\@]retval" },
        },
        styler = "`",
    },
    code = {
        start = { "[\\@]code" },
        ending = { "[\\@]endcode" },
    },
    return_statement = {
        "[\\@]return",
        "[\\@]*return*",
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
