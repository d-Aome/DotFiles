local null_ls = require 'null-ls'

require('mason-null-ls').setup {
    ensure_installed = {
        -- Formatters
        'clang-format',
        'isort',
        'black',
        'gofumpt',
        'goimports-reviser',
        'golines',
        'prettier',
        'stylua',

        -- Linters
        'luacheck',
        'flake8',
        'shellcheck',
        'eslint_d',
    },

    automatic_installation = true,
}

null_ls.setup {
    sources = {
        -- ========================================================================== --
        --                                  CODE_ACTIONS                             --
        -- ========================================================================== --
        require 'none-ls.code_actions.eslint_d',
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
                'AutoPreferDouble',
            },
        },
        -- Web
        null_ls.builtins.formatting.prettier.with {
            extra_args = {
                '--single-qoute',
                '--jsx-single-qoute',
                '-trailing-comma',
                'all',
            },
        },
        -- C/C++
        null_ls.builtins.formatting.clang_format.with {
            extra_args = {
                '-style={ \
                IndentWidth: 4, \
                TabWidth: 4, \
                UseTab: Never, \
                AccessModifierOffset: 0, \
                IndentAccessModifiers: true, \
                PackConstructorInitializers: Never}',
            },
        },
        -- Python
        null_ls.builtins.formatting.isort.with {
            extra_args = { '--profile', 'black' },
        },
        null_ls.builtins.formatting.black.with {
            extra_args = {
                '--fast',
                '--line-length',
                '80',
            },
        },
        -- Go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports_reviser.with {
            extra_args = { '-rm-unused' },
        },
        null_ls.builtins.formatting.golines.with {
            extra_args = { '--max-len=80' },
        },

        -- ========================================================================== --
        --                                  DIAGNOSTICS                               --
        -- ========================================================================== --
        require('none-ls-luacheck.diagnostics.luacheck').with {
            extra_args = { '--globals', 'love', 'vim' },
        },
        -- Python
        require 'none-ls.diagnostics.flake8',

        -- Bash
        require 'none-ls-shellcheck.diagnostics',

        -- JS / TS / Vue (Handles all standard web filetypes automatically)

        require('none-ls.diagnostics.eslint_d').with {

            filetypes = { 'javascript', 'javascriptreact', 'vue' },
        },
    },

    root_dir = require('null-ls.utils').root_pattern('.null-ls-root', 'Makefile', '.git'),
    diagnostics_format = '[#{c}] #{m} (#{s})',
    on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- Sync formatting
                    vim.lsp.buf.format { async = false, timeout_ms = 500, bufnr = bufnr }
                end,
            })
        end
    end,
}
