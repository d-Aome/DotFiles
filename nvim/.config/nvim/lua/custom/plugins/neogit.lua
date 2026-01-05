return {
    'NeoGitOrg/neogit',
    lazy = true,
    dependecies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
        'nvim-telescope/tellesope.nvim',
    },
    cmd = 'Neogit',
    keys = {
        keys = {
            { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
        },
    },
}
