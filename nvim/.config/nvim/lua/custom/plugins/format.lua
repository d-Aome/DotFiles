return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				css = { "prettier" },
				html = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				python = { "black" },
				go = { "gofumpt", "goimports-reviser", "golines" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				c_cpp = { "clang-format" },
			},
			formatters = {
				["clang-format"] = {
					prepend_args = {
						"-style={ IndentWidth: 4, TabWidth: 4, UseTab: Never, AccessModifierOffset: 0, IndentAccessModifiers: true }",
					},
				},
				["goimports-reviser"] = {
					prepend_args = { "-rm-unused" },
				},
				golines = {
					prepend_args = { "--max-len=80" },
				},
				black = {
					prepend_args = { "--fast", "--line-length", "80" },
				},
				["prettier"] = {
					prepend_args = {
						"--single-qoute",
						"config-precedence",
						"prefer-file",
					},
				},
			},
		},
	},
}
