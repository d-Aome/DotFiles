return {
	"xiyaowong/transparent.nvim",
	lazy = false,
	config = function()
		local transparent = require("transparent")
		transparent.clear_prefix("Telescope")
		transparent.clear_prefix("Notify")
		transparent.setup({
			-- table: default groups
			groups = {
				"Normal",
				"NormalNC",
				"Comment",
				"Constant",
				"Special",
				"Identifier",
				"Statement",
				"PreProc",
				"Type",
				"Underlined",
				"Todo",
				"String",
				"Function",
				"Conditional",
				"Repeat",
				"Operator",
				"Structure",
				"LineNr",
				"NonText",
				"SignColumn",
				"CursorLine",
				"CursorLineNr",
				"StatusLine",
				"StatusLineNC",
				"EndOfBuffer",
			},
			-- table: additional groups that should be cleared
			extra_groups = {
				"NoiceCmdlinePopup",
				"NoiceCmdlinePopupBorder",
				"NoiceCmdlineIcon",
				"NoiceCmdlineIconSearch",
			},
			exclude_groups = {
				"NormalFloat", -- Keeps background for most floating windows
				"FloatBorder",
				"TelescopeSelectionCaret",
				"TelescopeMultiSelection",
			},
			-- function: code to be executed after highlight groups are cleared
			-- Also the user event "TransparentClear" will be triggered
			on_clear = function() end,
		})
	end,
}
