local M = {}

M.opts = function()
    local mason_registry = require 'mason-registry'
    local codelldb = mason_registry.get_package 'codelldb'
    local extension_path = require('mason.settings').current.install_root_dir .. '/extensions/'
    local codelldb_path = extension_path .. 'adapter/codelldb'
    local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

    local cfg = require 'rustaceanvim.config'
    vim.g.rustaceanvim = {
        dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
            ['rust-analyzer'] = {
                checkOnSave = false,
            },
        },
        on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd('BufFilePost', {
                buffer = bufnr,
                callback = function()
                    vim.cmd 'RustLsp flycheck'
                end,
            })
        end,
    }
end

return M
