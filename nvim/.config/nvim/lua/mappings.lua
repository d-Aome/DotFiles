local map = vim.keymap.set

-- =============================================================================
-- 1. General Keymaps
-- =============================================================================
-- Yank to end of line
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Save files
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Jump up/down half a page and recenter
map({ "n", "v" }, "<C-d>", "<C-d>zz", { desc = "Jump Down Half a Page" })
map({ "n", "v" }, "<C-u>", "<C-u>zz", { desc = "Jump Up Half a Page" })

-- Move lines in Visual Mode without clipboard
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Line Down" })
map("v", "<A-k>", ":m '>-2<CR>gv=gv", { desc = "Move Line Up" })

-- Maintain selection after indenting
map("v", "<", "<gv", { desc = "Indent Line Left" })
map("v", ">", ">gv", { desc = "Indent Line Right" })

-- Center search results
map("n", "n", "nzzzv", { desc = "Go to Next Match" })
map("n", "N", "Nzzzv", { desc = "Go to Previous Match" })

-- The "Greatest Remap": Paste over selection without losing current register
map("x", "<leader>p", '"_dP', { desc = "Paste over selection (void reg)" })

-- Keep cursor position when joining lines
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- New line without entering insert mode
map("n", "<leader>o", "o<ESC>", { desc = "Insert line below" })
map("n", "<leader>O", "O<ESC>", { desc = "Insert line above" })

-- Clear search highlight
map("n", "<leader>n", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear highlight" })

-- Disable Q (prevents accidental Ex mode)
map("n", "Q", "<nop>")

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- Close current window
map("n", "<leader>x", "<cmd>close<cr>", { desc = "Window: Close" })
-- Code Actions
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Actions" })
-- =============================================================================
-- 2. Plugin Specific Mappings
-- =============================================================================

-- Oil.nvim
map("n", "-", "<CMD>Oil<CR>", { desc = "Open Parent directory" })

-- Telescope: Search Config Files
map("n", "<leader>fn", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.stdpath("config"),
	})
end, { desc = "Search Neovim Config Files" })

-- Telescope: Other
map("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "Command Palette" })
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Telescope TODOs" })

-- Noice
map("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Messages" })

-- Trouble
map("n", "<leader>tx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>tf", "<cmd>TodoQuickFix<CR>", { desc = "Show all Todo's in project" })

-- Neogen
map("n", "<Leader>nf", function()
	require("neogen").generate()
end, { desc = "Generate Documentation" })

-- =============================================================================
-- 3. Harpoon 2 Configuration & Mappings
-- =============================================================================
local harpoon = require("harpoon")
harpoon:setup({
	settings = { save_on_toggle = true, sync_on_ui_close = true },
})

map("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Harpoon Add" })
map("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })

-- Navigating Harpoon List
for i = 1, 7 do
	vim.keymap.set("n", string.format("<leader>%d", i), function()
		harpoon:list():select(i)
	end, { desc = string.format("Harpoon: Jump to mark %d", i) })
end

-- Custom Telescope integration for Harpoon
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end
	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({ results = file_paths }),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

map("n", "<leader>e", function()
	toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })
