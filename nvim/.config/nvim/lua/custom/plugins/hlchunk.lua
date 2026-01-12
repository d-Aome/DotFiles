return {
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				-- Disable the rainbow brackets
				-- Disable the "chunk" (the vertical line that highlights the current scope)
				chunk = {
					enable = false,
				},
				-- Enable ONLY the indent guides
				indent = {
					enable = true,
					use_treesitter = true, -- High performance using Tree-sitter
					style = {
						"#005459",
						"#FF7F00",
						"#FFFF00",
						"#00FF00",
						"#00FFFF",
						"#0000FF",
						"#8B00FF",
						"#FF0000",
					}, -- Optional: different characters for the guide
					chars = { "│" },
				},
			})
		end,
	},
}
