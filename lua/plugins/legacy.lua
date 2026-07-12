return {
  -- Keep useful vimscript-era plugins, now managed by lazy.nvim.
  {
    'junegunn/vim-easy-align',
    cmd = { 'EasyAlign' },
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' }, desc = 'Easy Align' },
    },
  },
}
