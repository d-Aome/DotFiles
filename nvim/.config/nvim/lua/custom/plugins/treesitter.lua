return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    -- This is the critical change: Use opts instead of manual require
    opts = {
      ensure_installed = {
        -- Base & Shell
        'bash',
        'fish',
        'make',
        'cmake',
        'toml',
        'yaml',
        'printf',
        'diff',

        -- C / C++ / Rust
        'c',
        'cpp',
        'rust',

        -- Go
        'go',
        'gomod',
        'gosum',
        'gotmpl',
        'gowork',

        -- Web & Docs
        'html',
        'markdown',
        'markdown_inline',
        'query',

        -- Neovim / Lua
        'lua',
        'luadoc',
        'vim',
        'vimdoc',
      },
      auto_install = true,
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
    },
  },
}
