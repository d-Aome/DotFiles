local map = vim.keymap.set

-- ========================================================================== --
--                               WHICH-KEY SETUP                              --
-- ========================================================================== --
-- This registers the group names so the menu shows "+Find", "+Git", etc.
local wk = require 'which-key'
wk.add {
    { '<leader>c', group = 'Code / LSP' },
    { '<leader>f', group = 'Find (Telescope)' },
    { '<leader>g', group = 'Git' },
    { '<leader>h', group = 'Harpoon' },
    { '<leader>n', group = 'Notes / Noice' },
    { '<leader>t', group = 'Toggle / Themes' },
    { '<leader>w', group = 'Window / WhichKey' },
    { '<leader>x', group = 'Diagnostics (Trouble)' },
}

-- ========================================================================== --
--                             CORE KEYBINDINGS                               --
-- ========================================================================== --

-- -- File & Window Management --
map({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<cr>', { desc = 'Save file' })
map('n', '<leader>q', '<cmd>close<cr>', { desc = 'Window: Close' }) -- Changed from <leader>x to avoid conflict
map('n', 'Q', '<nop>', { desc = 'Disable Ex Mode' })

-- -- Navigation & Centering --
map({ 'n', 'v' }, '<C-d>', '<C-d>zz', { desc = 'Jump Down Half Page (Center)' })
map({ 'n', 'v' }, '<C-u>', '<C-u>zz', { desc = 'Jump Up Half Page (Center)' })
map('n', 'n', 'nzzzv', { desc = 'Next Match (Center)' })
map('n', 'N', 'Nzzzv', { desc = 'Prev Match (Center)' })
-- -- Line Manipulation & Yanking --
map('n', 'Y', 'y$', { desc = 'Yank to end of line' })
map('n', 'J', 'mzJ`z', { desc = 'Join lines (keep cursor)' })
map('n', '<leader>o', 'o<ESC>', { desc = 'Insert line below' })
map('n', '<leader>O', 'O<ESC>', { desc = 'Insert line above' })
map('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move Line Down', silent = true })
map('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move Line Up', silent = true })

-- -- Visual Mode Moves (The Primeagen mappings) --
map('v', '<A-j>', ':m \'>+1<CR>gv=gv', { desc = 'Move Line Down' })
map('v', '<A-k>', ':m \'<-2<CR>gv=gv', { desc = 'Move Line Up' })
map('v', '<', '<gv', { desc = 'Indent Left' })
map('v', '>', '>gv', { desc = 'Indent Right' })
map('x', '<leader>p', '"_dP', { desc = 'Paste over selection (Keep clipboard)' })

-- -- TMUX Navigation --
map('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Window: Left' })
map('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Window: Down' })
map('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Window: Up' })
map('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Window: Right' })
map('n', '<leader>\\', '<cmd>TmuxNavigatePrevious<cr>', { desc = 'Window: Previous' })

-- -- Utility --
map('n', '<leader>n', '<cmd>nohlsearch<CR>', { silent = true, desc = 'Clear highlight' })
map('n', '<leader>/', 'gcc', { desc = 'Toggle Comment', remap = true })
map('v', '<leader>/', 'gc', { desc = 'Toggle Comment', remap = true })
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open Parent Directory (Oil)' })

-- ========================================================================== --
--                           LSP & FORMATTING                                --
-- ========================================================================== --

map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP Code Actions' })
map('n', '<leader>ds', vim.diagnostic.setloclist, { desc = 'LSP Diagnostic Loclist' })

-- Formatting
map({ 'n', 'x' }, '<leader>fm', function()
    require('conform').format { lsp_fallback = true }
end, { desc = 'Format Buffer' })

-- Documentation (Neogen)
map('n', '<leader>cg', function()
    require('neogen').generate()
end, { desc = 'Generate Docs (Neogen)' })

vim.keymap.set('n', 'K', function()
    -- 1. Try to load the plugin safely
    local has_plugin, pretty_hover = pcall(require, 'pretty_hover')

    if has_plugin then
        -- 2. If plugin loads, try to run its hover function safely
        local success, err = pcall(pretty_hover.hover)

        -- 3. If the plugin crashes during execution, catch it and fallback
        if not success then
            -- Optional: Print a small warning so you know it failed
            vim.notify('Pretty Hover failed: ' .. tostring(err), vim.log.levels.WARN)
            vim.lsp.buf.hover()
        end
    else
        -- 4. If the plugin isn't installed/found, use native hover immediately
        vim.lsp.buf.hover()
    end
end, { desc = 'Hover (Smart Fallback)' })

-- ========================================================================== --
--                                 DEBUGGING                                  --
-- ========================================================================== --
map('n', '<F5>', function()
    require('dap').continue()
end, { desc = 'Debug: Start/Continue' })
map('n', '<F1>', function()
    require('dap').step_into()
end, { desc = 'Debug: Step Into' })
map('n', '<F2>', function()
    require('dap').step_over()
end, { desc = 'Debug: Step Over' })
map('n', '<F3>', function()
    require('dap').step_out()
end, { desc = 'Debug: Step Out' })
map('n', '<leader>b', function()
    require('dap').toggle_breakpoint()
end, { desc = 'Debug: Toggle Breakpoint' })
map('n', '<leader>B', function()
    require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })
map('n', '<F7>', function()
    require('dapui').toggle()
end, { desc = 'Debug: See last session result.' })
-- ========================================================================== --
--                               TELESCOPE                                    --
-- ========================================================================== --
local builtin = require 'telescope.builtin'

-- Files & Generic
map('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
map('n', '<leader>fa', function()
    builtin.find_files { follow = true, no_ignore = true, hidden = true }
end, { desc = 'Find All (Hidden/Ignored)' })
map('n', '<leader>f.', builtin.oldfiles, { desc = 'Find Recent Files' })
map('n', '<leader><leader>', builtin.buffers, { desc = 'Find Buffers' })

-- Search & Grep
map('n', '<leader>fw', builtin.grep_string, { desc = 'Find Current Word' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Grep (Root Dir)' })
map('n', '<leader>f/', function()
    builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep (Open Files)' }
end, { desc = 'Grep (Open Files)' })
map('n', '<leader>fz', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = 'Fuzzy Find in Buffer' })

-- Neovim Internals
map('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
map('n', '<leader>fk', builtin.keymaps, { desc = 'Find Keymaps' })
map('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
map('n', '<leader>fr', builtin.resume, { desc = 'Resume Last Search' })
map('n', '<leader>fn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = 'Search Neovim Config' })

local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

vim.keymap.set('n', '<leader>fo', function()
    builtin.find_files {
        prompt_title = '< Open Directory in Oil >',
        -- This command forces Telescope to only show directories
        find_command = { 'fd', '--type', 'd', '--hidden', '--exclude', '.git' },

        attach_mappings = function(prompt_bufnr, map)
            -- Overwrite the default "Enter" action
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)

                -- Get the selected directory path
                local selection = action_state.get_selected_entry()

                -- Open Oil at that specific path
                if selection then
                    require('oil').open(selection.path)
                end
            end)
            return true
        end,
    }
end, { desc = 'Find directory and open in Oil' })

-- ========================================================================== --
--                                 PLUGINS                                    --
-- ========================================================================== --
-- Todo comments
vim.keymap.set('n', ']t', function()
    require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function()
    require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

-- You can also specify a list of valid jump keywords

vim.keymap.set('n', ']t', function()
    require('todo-comments').jump_next { keywords = { 'ERROR', 'WARNING' } }
end, { desc = 'Next error/warning todo comment' })
-- -- Git (Neogit) --
map('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Open Neogit' })
-- Git (LazyGit)
map('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
-- -- Themes (NvChad) --
map('n', '<leader>th', function()
    require('nvchad.themes').open()
end, { desc = 'NvChad Themes' })

-- -- Trouble --
map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Trouble: Diagnostics' })
map('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Trouble: Buffer Diagnostics' })
map('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Trouble: Symbols' })
map(
    'n',
    '<leader>xl',
    '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
    { desc = 'Trouble: LSP Definitions' }
)
map('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Trouble: Loclist' })
map('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>', { desc = 'Trouble: Quickfix' })
map('n', '<leader>xt', '<cmd>TodoQuickFix<CR>', { desc = 'Trouble: Todo\'s' })

-- -- Noice --
map('n', '<leader>nd', '<cmd>NoiceDismiss<CR>', { desc = 'Dismiss Notifications' })

-- -- WhichKey Direct --
map('n', '<leader>wK', '<cmd>WhichKey <CR>', { desc = 'Show All Keymaps' })
map('n', '<leader>wk', function()
    vim.cmd('WhichKey ' .. vim.fn.input 'WhichKey: ')
end, { desc = 'WhichKey Lookup' })

-- ========================================================================== --
--                                 HARPOON                                    --
-- ========================================================================== --
local harpoon = require 'harpoon'
harpoon:setup { settings = { save_on_toggle = true, sync_on_ui_close = true } }

-- Actions
map('n', '<leader>a', function()
    harpoon:list():add()
end, { desc = 'Harpoon: Add File' })
map('n', '<C-e>', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon: Menu' })

-- Navigation (1-9)
for i = 1, 9 do
    map('n', '<leader>' .. i, function()
        harpoon:list():select(i)
    end, { desc = 'Harpoon: Go to ' .. i })
end

-- Custom Telescope Integration for Harpoon
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end
    require('telescope.pickers')
        .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table { results = file_paths },
            previewer = require('telescope.config').values.file_previewer {},
            sorter = require('telescope.config').values.generic_sorter {},
        })
        :find()
end

map('n', '<leader>e', function()
    toggle_telescope(harpoon:list())
end, { desc = 'Harpoon: Telescope Window' })
