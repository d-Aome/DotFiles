return {
	-- 1. Harpoon 2: Quick File Switching
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
				},
			})
		end,
	},

	-- 2. Vim-test & Vimux: Test Runner
	{
		"vim-test/vim-test",
		dependencies = { "preservim/vimux" },
		config = function()
			-- Use Vimux as the strategy to run tests in a small tmux pane
			vim.cmd("let test#strategy = 'vimux'")
		end,
		keys = {
			{ "<leader>tn", ":TestNearest<CR>", desc = "[T]est: [N]earest" },
			{ "<leader>tf", ":TestFile<CR>", desc = "[T]est: [F]ile" },
			{ "<leader>ts", ":TestSuite<CR>", desc = "[T]est: [S]uite" },
			{ "<leader>tl", ":TestLast<CR>", desc = "[T]est: [L]ast" },
			{ "<leader>tv", ":TestVisit<CR>", desc = "[T]est: [V]isit" },
		},
	},

	-- 3. Neogen: Annotation/Docstring Generator
	{
		"danymat/neogen",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true, -- Runs require('neogen').setup()
		keys = {
			{
				"<leader>gd",
				function()
					require("neogen").generate()
				end,
				desc = "Generate Documentation (Neogen)",
			},
		},
	},
}
