return {
    'christoomey/vim-tmux-navigator',
    cmd = {
        'TmuxNavigateLeft',
        'TmuxNavigateDown',
        'TmuxNavigateUp',
        'TmuxNavigateRight',
        'TmuxNavigatePrevious',
        'TmuxNavigatorProcessList',
    },
    keys = {
        { '<C-h>', '<cmd><C-U>TmuxNavigateLeft<cr>', desc = 'Window: Move Left' },
        { '<C-j>', '<cmd><C-U>TmuxNavigateDown<cr>', desc = 'Window: Move Down' },
        { '<C-k>', '<cmd><C-U>TmuxNavigateUp<cr>', desc = 'Window: Move Up' },
        { '<C-l>', '<cmd><C-U>TmuxNavigateRight<cr>', desc = 'Window: Move Right' },
        { '<leader>\\', '<cmd><C-U>TmuxNavigatePrevious<cr>', desc = 'Window: Previous' },
    },
}
