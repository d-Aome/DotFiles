return {
    "ThePrimeagen/vim-be-good",
    -- ========================================================================== --
    --                              LSP CONFIGURATION                             --
    --          Servers: clangd, rust_analyzer, ts_ls, lua_ls & Mason Setup       --
    -- ========================================================================== --
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require "configs.mason-lspconfig"
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    --
    { import = "nvchad.blink.lazyspec" },
    {
        "Saghen/blink.cmp",
        opts = require "configs.blink",
    },
    {
        "nvim-tree/nvim-tree.lua",
        enabled = false,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        lazy = false, -- This plugin is already lazy
        ft = "rust",
        config = function()
            require "configs.rust"
        end,
    },
    {
        "saecki/crates.nvim",
        ft = { "toml" },
        config = function()
            require "configs.crates"
        end,
    },
    -- ========================================================================== --
    --                                 TREESITTER                                 --
    --             Syntax Highlighting, Indentation & Language Parsers            --
    -- ========================================================================== --
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "HiPhish/rainbow-delimiters.nvim" },
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        event = { "BufReadPost", "BufNewFile" },
        opts = require("configs.treesitter").opts,
        config = require("configs.treesitter").setup,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufRead",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
        },
        opts = {
            multiwindow = true,
        },
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            require "configs.rainbow"
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    -- ========================================================================== --
    --                                   LINTING                                  --
    --                 Static Analysis, Diagnostics & nvim-lint                   --
    -- ========================================================================== --
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require "configs.lint"
        end,
    },
    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        config = function()
            require "configs.mason-lint"
        end,
    },
    -- ========================================================================== --
    --                                 FORMATTING                                 --
    --             Auto-Formatting, Conform.nvim, Prettier & StyLua               --
    -- ========================================================================== --
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require "configs.conform",
        config = function(_, opts)
            ---@diagnostic disable-next-line: different-requires
            require("conform").setup(opts)
        end,
    },
    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require "configs.mason-conform"
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = "Telescope",
        opts = function()
            return require "configs.telescope"
        end,
    },
    -- ========================================================================== --
    --                                  UTILITIES                                 --
    --                     Workflow Enhancements & Helper Tools                   --
    -- ========================================================================== --
    {
        "stevearc/oil.nvim",
        dependencies = { "benomahony/oil-git.nvim" }, -- Added from your init.lua
        lazy = false, -- Matches your original config
        opts = require "configs.oil",
        config = function(_, opts)
            ---@diagnostic disable-next-line: different-requires
            require("oil").setup(opts)
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "NeoGitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Neogit",
        keys = {
            keys = {},
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        config = function()
            local harpoon = require "harpoon"
            harpoon:setup {
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = true,
                },
            }
        end,
    },
    {
        "danymat/neogen",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = true, -- Runs require('neogen').setup()
        keys = {},
    },
    -- ========================================================================== --
    --                               USER INTERFACE                               --
    --          Themes (TokyoNight), Icons, Status Line & Transparency            --
    -- ========================================================================== --
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        opts = require "configs.inline-diagnostics",
        config = function(_, opts)
            require("tiny-inline-diagnostic").setup(opts)
            vim.diagnostic.config { virtual_text = false }
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                config = require("configs.noice").notify_config,
            },
        },
        opts = function()
            return require("configs.noice").noice_opts
        end,
    },
    {
        "Fildo7525/pretty_hover",
        event = "LspAttach",
        opts = require "configs.pretty_hover",
        config = function(_m, opts)
            require("pretty_hover").setup(opts)
        end,
    },
}
