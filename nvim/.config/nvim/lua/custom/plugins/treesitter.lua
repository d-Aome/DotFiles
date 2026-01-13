return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		-- This is the critical change: Use opts instead of manual require
		dependencies = {
			{
				"HiPhish/rainbow-delimiters.nvim",
				config = function()
					require("rainbow-delimiters.setup").setup({
						strategy = {
							[""] = "rainbow-delimiters.strategy.global",
							commonlisp = "rainbow-delimiters.strategy.local",
						},
						query = {
							[""] = "rainbow-delimiters",
							lua = "rainbow-blocks",
							latex = "rainbow-blocks",
							javascript = "rainbow-delimiters-react",
							c = "rainbow-delimiters",
							cpp = "rainbow-delimiters",
							typescript = "rainbow-delimiters",
							tsx = "rainbow-delimiters",
						},
						highlight = {
							"RainbowDelimiterRed",
							"RainbowDelimiterOrange",
							"RainbowDelimiterYellow",
							"RainbowDelimiterGreen",
							"RainbowDelimiterBlue",
							"RainbowDelimiterViolet",
							"RainbowDelimiterCyan",
						},
					})
				end,
			},
		},
		config = function(_, opts)
			-- This ensures that the configuration is actually applied
			require("nvim-treesitter.configs").setup(opts)

			vim.treesitter.language.register("tsx", "javascriptreact")
		end,
		opts = {
			ensure_installed = {
				-- Base & Shell
				"bash",
				"fish",
				"make",
				"cmake",
				"toml",
				"yaml",
				"printf",
				"diff",

				-- C / C++ / Rust
				"c",
				"cpp",
				"rust",

				-- Go
				"go",
				"gomod",
				"gosum",
				"gotmpl",
				"gowork",

				-- Web & Docs
				"html",
				"markdown",
				"markdown_inline",
				"query",
				"javascript",
				"tsx",
				"typescript",

				-- Neovim / Lua
				"lua",
				"luadoc",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			highlight = {
				enable = true,
				use_languagetree = true,
			},
			indent = { enable = true },
			textobjexts = {
				select = {
					enable = false,
				},
			},
		},
	},
}
