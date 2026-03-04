if vim.loader and vim.loader.enable then
  vim.loader.enable()
end

vim.api.nvim_create_user_command('NvimLazyProfile', function()
  vim.cmd('Lazy profile')
end, { desc = 'Open lazy.nvim profile view' })

vim.api.nvim_create_user_command('NvimHealth', function()
  vim.cmd('checkhealth')
end, { desc = 'Run Neovim health checks' })

vim.api.nvim_create_user_command('NvimStartupReport', function()
  local ok, lazy = pcall(require, 'lazy')
  if not ok then
    vim.notify('lazy.nvim not loaded', vim.log.levels.WARN)
    return
  end
  local stats = lazy.stats()
  local msg = string.format(
    'Startup: %.2fms | Plugins: %d/%d',
    stats.startuptime or 0,
    stats.loaded or 0,
    stats.count or 0
  )
  vim.notify(msg, vim.log.levels.INFO)
end, { desc = 'Show startup timing summary' })
