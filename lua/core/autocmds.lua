local augroup = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('restore_cursor_position'),
  pattern = '*',
  callback = function()
    if vim.fn.line('\'"') > 1 and vim.fn.line('\'"') <= vim.fn.line('$') then
      vim.fn.execute('normal! g\'"')
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup('set_ejs_to_html'),
  pattern = '*.ejs',
  callback = function()
    vim.bo.filetype = 'html'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'checkhealth',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('java_indent'),
  pattern = 'java',
  callback = function(event)
    vim.bo[event.buf].expandtab = true
    vim.bo[event.buf].tabstop = 4
    vim.bo[event.buf].shiftwidth = 4
    vim.bo[event.buf].softtabstop = 4
  end,
})
