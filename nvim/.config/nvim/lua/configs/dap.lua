local dap = require 'dap'
local dap_view = require 'dap-view' -- Changed from dapui

-- 1. Setup Mason (Installs adapters)
require('mason-nvim-dap').setup {
    automatic_installation = true,
    handlers = {},
    ensure_installed = {
        'delve',
        'debugpy',
        'codelldb',
        'js-debug-adapter',
    },
}

-- 2. Setup DAP View
-- nvim-dap-view is more minimalist; most of the 'icons' logic is handled by the plugin defaults.
dap_view.setup {
    auto_toggle = true, -- Automatically opens/closes when session starts/ends
}

-- NOTE: We removed the dap.listeners.after... block.
-- dap-view handles this automatically if auto_toggle is true.

-- 3. Language Specific Configs

-- GO
require('dap-go').setup {
    delve = {
        detached = vim.fn.has 'win32' == 0,
    },
}

-- PYTHON
-- Using your existing path logic
local python_path = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python'
require('dap-python').setup(python_path)

vim.keymap.set('n', '<leader>dpr', function()
    require('dap-python').test_method()
end, { desc = 'Run DAP Python test method' })

-- C++ / C / RUST
dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
        args = { '--port', '${port}' },
    },
}

local cpp_config = {
    {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

dap.configurations.cpp = cpp_config
dap.configurations.c = cpp_config
dap.configurations.rust = cpp_config

-- ========================================================================== --
--                           JAVASCRIPT / TYPESCRIPT                          --
-- ========================================================================== --

-- Keeping your manual adapter setup as is
dap.adapters['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
        command = 'node',
        args = {
            os.getenv 'HOME' .. '/vscode-js-debug/out/src/vsDebugServer.js',
            '${port}',
        },
    },
}

dap.adapters['node-terminal'] = dap.adapters['pwa-node']

local js_based_languages = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

for _, language in ipairs(js_based_languages) do
    local configs = {
        {
            name = 'Local: Next.js: launch and debug',
            type = 'pwa-node',
            request = 'launch',
            program = '${workspaceFolder}/node_modules/next/dist/bin/next',
            args = { 'dev' },
            cwd = '${workspaceFolder}',
            console = 'integratedTerminal',
            skipFiles = { '<node_internals>/**', 'node_modules/**' },
            runtimeArgs = { '--inspect' },
        },
        {
            type = 'pwa-node',
            request = 'launch',
            name = 'Local: Launch file (Normal Node)',
            program = '${file}',
            cwd = '${workspaceFolder}',
            stopOnEntry = true,
            console = 'integratedTerminal',
        },
        {
            type = 'pwa-node',
            request = 'attach',
            name = 'Local: Attach to Node process',
            processId = require('dap.utils').pick_process,
            cwd = vim.fn.getcwd(),
        },
    }

    if language == 'typescript' or language == 'typescriptreact' then
        table.insert(configs, 1, {
            type = 'pwa-node',
            request = 'launch',
            name = 'Local: Launch Current File (ts-node)',
            program = '${file}',
            cwd = '${workspaceFolder}',
            runtimeArgs = { '--loader', 'ts-node/esm' },
            sourceMaps = true,
            stopOnEntry = true,
            console = 'integratedTerminal',
        })
    end

    dap.configurations[language] = configs
end
