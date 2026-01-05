return {
    -- 1. Harpoon 2: Quick File Switching
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
        config = function()
        local harpoon = require('harpoon')
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })
        end,
    },

    -- 2. Vim-test & Vimux: Test Runner
    {
        'vim-test/vim-test',
        dependencies = { 'preservim/vimux' },
        config = function()
        -- Use Vimux as the strategy to run tests in a small tmux pane
        vim.cmd("let test#strategy = 'vimux'")
        end,
        keys = {
            { '<leader>t', ':TestNearest<CR>', desc = 'Test: Nearest' },
            { '<leader>T', ':TestFile<CR>', desc = 'Test: File' },
            { '<leader>ta', ':TestSuite<CR>', desc = 'Test: Suite' },
            { '<leader>l', ':TestLast<CR>', desc = 'Test: Last' },
            { '<leader>g', ':TestVisit<CR>', desc = 'Test: Visit' },
        },
    },

    -- 3. Neogen: Annotation/Docstring Generator
    {
        'danymat/neogen',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = true, -- Runs require('neogen').setup()
        keys = {
            {
                '<leader>nf',
                function()
                require('neogen').generate()
                end,
                desc = 'Generate Documentation (Neogen)',
            },
        },
    },
}
