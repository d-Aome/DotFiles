local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = function(_, _bufnr) end
local _on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- local lspconfig = require("lspconfig") -- pre nvim 0.11
local lspconfig = require "nvchad.configs.lspconfig" -- nvim 0.11

-- for ts_ls and volar
local vue_language_server_path = vim.fn.stdpath "data"
    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

-- list of all servers configured.
lspconfig.servers = {
    "lua_ls",
    "neocmake",
    "ts_ls",
    "clangd",
    "gopls",
    "vue_ls",
    "rust_analyzer",
}

-- list of servers configured with default config.
local default_servers = { "html", "cssls", "jedi_language_server", "ruff", "bashls", "zls" }

-- lsps with default config
for _, lsp in ipairs(default_servers) do
    -- lspconfig[lsp].setup({ -- pre nvim 0.11
    vim.lsp.config(lsp, { -- nvim 0.11
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

-- typescript, javascript, react
vim.lsp.config("ts_ls", {
    on_attach = function(client, bufnr)
        -- Disable formatting so Prettier (via conform) handles it
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        client.server_capabilities.hoverProvider = true
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
    filetype = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "javascript", "typescript", "vue" },
            },
        },
    },
    settings = {
        javascript = {
            preferences = {
                quoteStyle = "single", -- Fixed typo: qouteStyle -> quoteStyle

                displayPartsForJSDoc = true,
                check = { npmIsInstalled = false },
            },
        },
        typescript = {
            displayPartsForJSDoc = true,
            check = { npmIsInstalled = false },
            preferences = {
                quoteStyle = "single", -- Fixed typo: qouteStyle -> quoteStyle
            },
        },
    },
})

vim.lsp.config("volar", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
})

-- C/C++
vim.lsp.config("clangd", { -- nvim 0.11
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
})
-- Golang
vim.lsp.config("gopls", { -- nvim 0.11
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gotmpl", "gowork" },
    -- root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"), -- pre nvim 0.11
    root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"), -- nvim 0.11
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = true,
        },
    },
})

-- lspconfig.lua_ls.setup({ -- pre nvim 0.11
vim.lsp.config("lua_ls", { -- nvim 0.11
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
                -- globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand "$VIMRUNTIME/lua",
                    vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                    vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})

-- Neocmake with formatting enabled
vim.lsp.config("neocmake", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    init_options = {
        format = { enable = true },
        lint = { enable = true },
        scan_cmake_in_package = true,
        semantic_token = true,
    },
})
