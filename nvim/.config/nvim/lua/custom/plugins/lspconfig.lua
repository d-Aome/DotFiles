return {
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp",
		},
		config = function()
			-- 1. LSP Attach Logic (Keymaps & Highlighting)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
					map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
					map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- 2. Diagnostic Configuration
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				},
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local servers = {
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--function-arg-placeholders=0",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
					},
					capabilities = {
						documentFormattingProvider = false,
						documentRangeFormattingProvider = false,
					},
				},
				gopls = {
					settings = {
						gopls = {
							analyses = { unusedparams = true },
							completeUnimported = true,
							usePlaceholders = true,
							staticcheck = true,
						},
					},
					capabilities = {
						documentFormattingProvider = false,
						documentRangeFormattingProvider = false,
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { enable = false },
							workspace = {
								library = {
									vim.fn.expand("$VIMRUNTIME/lua"),
									vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
									"${3rd}/love2d/library",
								},
								maxPreload = 100000,
								preloadFileSize = 10000,
							},
							completion = { callSnippet = "Replace" },
						},
					},
				},
				neocmake = {
					init_options = {
						format = { enable = true },
						lint = { enable = true },
						scan_cmake_in_package = true,
						semantic_token = false,
					},
				},
				-- Default servers to be auto-installed
				html = {},
				cssls = {},
				ts_ls = {
					capabilities = {
						documentFormattingProvider = false,
						documentRangeFormattingProvider = false,
					},
				},
				eslint = {
					capabilities = {
						documentFormattingProvider = false,
						documentRangeFormattingProvider = false,
						semantic_token = false,
					},
				},
				pyright = {},
				ruff = {},
				prettier = {},
				rust_analyzer = {},
				bashls = {},
				shellcheck = {},
				shfmt = {},
			}

			-- 5. Mason Tool Installer Setup
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { "stylua" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- 6. Mason LSPConfig Setup
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
