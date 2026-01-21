local dap = require "dap"
local dapui = require "dapui"

-- 1. Setup Mason (Installs adapters)
require("mason-nvim-dap").setup {
    automatic_installation = true,
    handlers = {},
    ensure_installed = {
        "delve",
        "debugpy",
        "codelldb",
        "js-debug-adapter",
    },
}

-- 2. Setup DAP UI
dapui.setup {
    icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
    controls = {
        icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
        },
    },
}

-- Auto-open UI listeners
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- 3. Language Specific Configs

-- GO
require("dap-go").setup {
    delve = {
        detached = vim.fn.has "win32" == 0,
    },
}

-- PYTHON
local python_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
require("dap-python").setup(python_path)

vim.keymap.set("n", "<leader>dpr", function()
    require("dap-python").test_method()
end, { desc = "Run DAP Python test method" })

-- C++ / C / RUST
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.stdpath "data" .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
    },
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- ========================================================================== --
--                           JAVASCRIPT / TYPESCRIPT                          --
-- ========================================================================== --

-- MANUAL ADAPTER SETUP (Fixes the "path" and "port" errors)
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = {
            -- Ensure this path matches your manual install location
            os.getenv "HOME" .. "/vscode-js-debug/out/src/vsDebugServer.js",
            "${port}",
        },
    },
}

dap.adapters["node-terminal"] = dap.adapters["pwa-node"]

local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

for _, language in ipairs(js_based_languages) do
    -- Define the configurations table fresh for every language
    local configs = {
        {
            name = "Local: Next.js: launch and debug",
            type = "pwa-node",
            request = "launch",
            program = "${workspaceFolder}/node_modules/next/dist/bin/next",
            args = { "dev" },
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            runtimeArgs = { "--inspect" },
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Local: Launch file (Normal Node)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            stopOnEntry = true,
            console = "integratedTerminal",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Local: Attach to Node process",
            processId = require("dap.utils").pick_process,
            cwd = vim.fn.getcwd(),
        },
    }

    -- Insert TypeScript-specific config if needed
    if language == "typescript" or language == "typescriptreact" then
        table.insert(configs, 1, {
            type = "pwa-node",
            request = "launch",
            name = "Local: Launch Current File (ts-node)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeArgs = { "--loader", "ts-node/esm" },
            sourceMaps = true,
            stopOnEntry = true,
            console = "integratedTerminal",
        })
    end

    dap.configurations[language] = configs
end
