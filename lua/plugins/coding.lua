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
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local languages = {
        'bash',
        'c',
        'css',
        'go',
        'html',
        'java',
        'javascript',
        'json',
        'just',
        'lua',
        'python',
        'rust',
        'vim',
      }

      require('nvim-treesitter').setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
      })
      require('nvim-treesitter').install(languages)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user-treesitter', { clear = true }),
        pattern = languages,
        callback = function(args)
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
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
