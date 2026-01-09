return {
    'barrett-ruth/live-server.nvim',
    config = function()
        require('lazy').setup {
            {
                'barrett-ruth/live-server.nvim',
                build = 'pnpm add -g live-server',
                cmd = { 'LiveServerStart', 'LiveServerStop' },
                config = true,
            },
        }
    end,
}
