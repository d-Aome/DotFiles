local overseer = require 'overseer'

overseer.register_template {
    name = 'Run Racket File',
    builder = function()
        local file = vim.fn.expand '%:p'
        return {
            cmd = 'racket',
            args = { file },
            components = { 'default', 'on_complete_notify' },
        }
    end,
    condition = {
        filetype = { 'racket' },
    },
}
