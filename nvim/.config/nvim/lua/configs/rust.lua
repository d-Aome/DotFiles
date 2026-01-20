local mason_registry = require "mason-registry"
local codelldb = mason_registry.get_package "codelldb"
local extension_path = require("mason.settings").current.install_root_dir .. "/extensions/"
local codelldb_path = extension_path .. "adapter/codelldb"
-- local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
-- If you are on Linux, replace the line above with the line below:
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
local cfg = require "rustaceanvim.config"

vim.g.rustaceanvim = {
    dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    },
}
