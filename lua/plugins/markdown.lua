return {
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'dhruvasagar/vim-table-mode',
    ft = 'markdown',
  },
  {
    'ferrine/md-img-paste.vim',
    ft = 'markdown',
  },
}
