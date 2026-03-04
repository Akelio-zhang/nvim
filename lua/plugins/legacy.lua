return {
  -- Keep useful vimscript-era plugins, now managed by lazy.nvim.
  {
    'junegunn/vim-easy-align',
    cmd = { 'EasyAlign' },
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' }, desc = 'Easy Align' },
    },
  },

  {
    'tpope/vim-fireplace',
    ft = 'clojure',
  },

  {
    dir = vim.fn.expand('~/my-prototype-plugin'),
    cond = function()
      return vim.fn.isdirectory(vim.fn.expand('~/my-prototype-plugin')) == 1
    end,
    event = 'VeryLazy',
  },
}
