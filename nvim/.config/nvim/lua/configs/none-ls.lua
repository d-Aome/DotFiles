local null_ls = require 'null-ls'

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local async_formatting = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.lsp.buf_request(
        bufnr,
        'textDocument/formatting',
        vim.lsp.util.make_formatting_params {},
        function(err, res, ctx)
            if err then
                local err_msg = type(err) == 'string' and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify('formatting: ' .. err_msg, vim.log.levels.WARN)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, 'modified') then
                return
            end

            if res then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or 'utf-16')
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd 'silent noautocmd update'
                end)
            end
        end
    )
end

require('mason-null-ls').setup {
    ensure_installed = {
        -- Formatters
        'clang-format',
        'gofumpt',
        'goimports-reviser',
        'golines',
        'prettier',
        'stylua',

        -- Linters
        'luacheck',
        'shellcheck',
        'eslint_d',
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
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                    vim.lsp.buf.format { async = false }
                end,
            })
        end
    end,
}
