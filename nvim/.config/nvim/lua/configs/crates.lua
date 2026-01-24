require("crates").setup {
    completion = {
        cmp = {
            enabled = true,
        },
        crates = {
            enabled = true,
            max_results = 15,
            min_chars = 2,
        },
    },
    lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
    },
}
