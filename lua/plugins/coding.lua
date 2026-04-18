return {
  -- git
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      preview_config = {
        border = 'rounded',
      },
    },
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'VeryLazy',
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        'c',
        'lua',
        'vim',
        'bash',
        'json',
        'python',
        'html',
        'css',
        'javascript',
        'java',
        'go',
        'rust',
        'just'
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  -- formatting
  {
    'stevearc/conform.nvim',
    event = 'VeryLazy',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier' },
        typescript = { 'prettierd', 'prettier' },
        javascriptreact = { 'prettierd', 'prettier' },
        typescriptreact = { 'prettierd', 'prettier' },
        html = { 'prettierd', 'prettier' },
        css = { 'prettierd', 'prettier' },
        json = { 'prettierd', 'prettier' },
        vue = { 'prettierd', 'prettier' },
        python = { 'ruff_format' },
        java = { 'google-java-format' },
        go = { 'goimports', 'gofmt' },
        rust = { 'rustfmt' },
      },
      formatters = {
        ['google-java-format'] = {
          prepend_args = { '--aosp' },
        },
      },
      format_on_save = {
        timeout_ms = 600,
        lsp_fallback = true,
      },
    },
  },

  -- comment
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = 'VeryLazy',
    config = true,
  },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {
      toggler = { line = '<SPACE>cc' },
      opleader = { line = '<SPACE>cc' },
    },
  },

  -- utils
  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    config = true,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    config = true,
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = true,
  },
}
