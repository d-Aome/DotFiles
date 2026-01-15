return {
	{},
	{
		-- 1. Icons (The foundation for all UI)
		{ "nvim-tree/nvim-web-devicons", lazy = true },

		-- 2. Statusline (Replaces the NvChad bottom bar)
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons", "folke/trouble.nvim" },
			opts = function()
				-- 1. Initialize Trouble Symbols
				local trouble = require("trouble")
				local symbols = trouble.statusline({
					mode = "lsp_document_symbols",
					groups = {},
					title = false,
					filter = { range = true },
					format = "{kind_icon}{symbol.name:Normal}",
					-- This ensures the background matches the 'c' section of lualine
					hl_group = "lualine_c_normal",
				})

				return {
					options = {
						theme = "eldritch", -- Or 'catppuccin', 'onedark', etc.
						component_separators = "|",
						section_separators = { left = "", right = "" },
						globalstatus = true,
					},
					sections = {
						lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
						lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
					},
				}
			end,
		},

		-- 3. Fancy UI for Messages, Cmdline, and Popupmenu
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			opts = {
				views = {
					cmdline_popup = {
						position = {
							row = "40%", -- Adjust this percentage to move it up or down
							col = "50%",
						},
						size = {
							width = 60,
							height = "auto",
						},
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = "53%", -- Positions the suggestion menu just below the centered cmdline
						col = "50%",
					},
				},
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = true, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			},
			dependencies = {
				"MunifTanjim/nui.nvim",
				{
					"rcarriga/nvim-notify",
					config = function()
						require("notify").setup({
							background_colour = "#000000",

							-- local buf = an integer
							-- local notification = a table with the notify.Record format
							highlights = {
								title = "NotifyTitle",
								icon = "NotifyIcon",
								border = "NotifyBorder",
								body = "NotifyBody",
							},
							merge_duplicates = true,
						})
					end,
				},
			},
		},

		-- 4. Color Highlighter (Shows #hex colors in CSS/Lua)
		{
			{
				"brenoprata10/nvim-highlight-colors",
				event = "VeryLazy",
				opts = {
					---Render style
					---@usage 'background'|'foreground'|'virtual'
					render = "virtual",

					---Set virtual symbol
					virtual_symbol = "■",

					---Enable named colors (Red, Blue, etc)
					enable_named_colors = true,

					---Enable Tailwind colors
					enable_tailwind = true,
				},
				config = function(_, opts)
					require("nvim-highlight-colors").setup(opts)
				end,
			},
		},
	},
}
