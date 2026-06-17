local null_ls = require 'null-ls'
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

require('mason-null-ls').setup {
    ensure_installed = {
        -- Formatters
        'clang-format',
        'gofumpt',
        'golines',
        'prettier',
        'stylua',
        'goimports',
        'prettier',
        -- Linters
        'luacheck',
        'shellcheck',
        'eslint_d',
        'ruff',
        'mypy',
    },

    automatic_installation = true,
}

null_ls.setup {
    methods = {
        null_ls.methods.DIAGNOSTICS,
        null_ls.methods.DIAGNOSTICS_ON_SAVE,
        null_ls.methods.DIAGNOSTICS_ON_OPEN,
    },
    sources = {
        -- ========================================================================== --
        --                                  CODE_ACTIONS                             --
        -- ========================================================================== --
        require 'none-ls.code_actions.eslint',
        require 'none-ls-shellcheck.code_actions',
        -- ========================================================================== --
        --                                  FORMATTING                                --
        -- ========================================================================== --
        -- Lua
        --

        null_ls.builtins.formatting.stylua.with {
            extra_args = {
                '--column-width',
                '120',
                '--line-endings',
                'Unix',
                '--indent-type',
                'Spaces',
                '--indent-width',
                '4',
                '--quote-style',
                'ForceSingle',
            },
        },
        -- Web
        null_ls.builtins.formatting.prettier.with {
            extra_args = {
                '--single-quote',
                '--jsx-single-quote',
                '--trailing-comma',
                'all',
            },
            filetypes = {
                'javascript',
                'json',
                'javascriptreact',
                'typescript',
                'typescriptreact',
                'yaml',
                'markdown',
                'vue',
                'css',
                'html',
                'jsonc',
                'graphql',
            },
        },
        -- Python
        require 'none-ls.formatting.ruff_format',

        -- C/C++
        null_ls.builtins.formatting.clang_format.with {
            extra_args = {
                '--style=file',
                '--fallback-style={ \
                IndentWidth: 4, \
                TabWidth: 4, \
                UseTab: Never, \
                AccessModifierOffset: 0, \
                IndentAccessModifiers: true, \
                PackConstructorInitializers: Never, \
                SortIncludes: false \
                AlignArrayOfStructures: None \
                BinPackArguments: false }',
            },
        },
        -- Go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.golines.with {
            extra_args = { '--max-len=100' },
        },

        -- ========================================================================== --
        --                                  DIAGNOSTICS                               --
        -- ========================================================================== --

        null_ls.builtins.diagnostics.mypy.with {
            extra_args = function()
                local virtual = os.getenv 'VIRTUAL_ENV' or os.getenv 'CONDA_PREFIX' or '/usr'
                return { '--python-executable', virtual .. '/bin/python3' }
            end,
        },
        require('none-ls-luacheck.diagnostics.luacheck').with {
            extra_args = { '--globals', 'love', 'vim' },
        },

        -- Bash
        require 'none-ls-shellcheck.diagnostics',

        -- JS / TS / Vue (Handles all standard web filetypes automatically)
        require('none-ls.diagnostics.eslint').with {
            filetypes = { 'javascript', 'javascriptreact', 'vue' },
        },
        -- Python
        require 'none-ls.diagnostics.ruff',
    },
    root_dir = require('null-ls.utils').root_pattern('.null-ls-root', 'Makefile', '.git'),
    diagnostics_format = '',
    on_attach = function(client, bufnr)
        if client:supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format { async = false }
                end,
            })
        end
    end,
}
