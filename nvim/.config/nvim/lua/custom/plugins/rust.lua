return {
    -- 1. Rustaceanvim: The "Heavy Lifter" for Rust
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false, -- This plugin handles its own lazy loading
        config = function()
        -- Path discovery for the debugger (codelldb)
        local extension_path = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/'
        local codelldb_path = extension_path .. 'adapter/codelldb'
        local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

        -- For macOS, the extension is usually .dylib
        if vim.loop.os_uname().sysname == "Darwin" then
            liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
            end

            vim.g.rustaceanvim = {
                dap = {
                    adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb_path, liblldb_path),
                },
                server = {
                    on_attach = function(_, bufnr)
                    -- Use the Rust-specific code action runner
                    vim.keymap.set('n', '<leader>ca', function()
                    vim.cmd.RustLsp 'codeAction'
                    end, { desc = 'Rust Code Action', buffer = bufnr })

                    -- Add an extra mapping to view the documentation
                    vim.keymap.set('n', 'K', function()
                    vim.cmd.RustLsp 'hover'
                    end, { desc = 'Rust Hover Actions', buffer = bufnr })
                    end,
                    default_settings = {
                        ['rust-analyzer'] = {
                            checkOnSave = { command = "clippy" }, -- Use clippy for linting
                            cargo = { allFeatures = true },
                        },
                    },
                },
            }
            end,
    },

    -- 2. Crates.nvim: Cargo.toml completion and info
    {
        'saecki/crates.nvim',
        ft = { 'toml' },
        opts = {
            completion = {
                -- Since you are using Blink.cmp, we don't strictly need cmp = true
                -- Blink will pick up the crates source automatically via LSP/Blink logic
                blink = { enabled = true },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
}
