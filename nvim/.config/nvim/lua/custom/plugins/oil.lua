return {
    {
        'stevearc/oil.nvim',
        dependencies = { 'benomahony/oil-git.nvim' }, -- Added from your init.lua
        lazy = false, -- Matches your original config
        opts = {
            view_options = {
                show_hidden = true, -- Matches the requirement you provided
            },
        },
        config = function(_, opts)
        require('oil').setup(opts)
        end,
    },
}
