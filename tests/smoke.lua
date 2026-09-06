-- Run from this checkout: nvim --headless -i NONE '+luafile tests/smoke.lua'
-- Requires the tools and parsers documented in README.md.
local function run()
  local function check(condition, message)
    assert(condition, message)
    print('PASS: ' .. message)
  end

  vim.api.nvim_exec_autocmds('User', { pattern = 'VeryLazy' })
  check(require('core.version').version() == '0.3.0', 'release version')

  for _, ft in ipairs({ 'sh', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'markdown' }) do
    vim.cmd('enew!')
    vim.bo.filetype = ft
    local buf = vim.api.nvim_get_current_buf()
    check(vim.treesitter.highlighter.active[buf] ~= nil, 'Treesitter highlighting: ' .. ft)
    check(vim.bo.indentexpr:find('nvim-treesitter', 1, true), 'Treesitter indentation: ' .. ft)
  end

  local dir = vim.fn.tempname()
  vim.fn.mkdir(dir, 'p')
  local file = dir .. '/smoke.js'
  vim.cmd.edit(file)
  local conform = require('conform')
  local formatters = conform.list_formatters_to_run(0)
  check(#formatters == 1, 'exactly one available frontend formatter')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { 'const value={a:1,b:2}' })
  vim.cmd.write()
  local formatted = table.concat(vim.fn.readfile(file), '\n')
  check(formatted == 'const value = { a: 1, b: 2 };', 'actual JavaScript format on save')

  -- Make both formatter commands resolvable without requiring the optional daemon.
  -- Only inspect selection here; do not execute prettier with prettierd arguments.
  local original_prettierd = conform.formatters.prettierd
  conform.formatters.prettierd = { command = vim.fn.exepath('prettier') }
  formatters = conform.list_formatters_to_run(0)
  check(#formatters == 1 and formatters[1].name == 'prettierd', 'prefer first formatter when both are available')
  conform.formatters.prettierd = original_prettierd

  vim.cmd.edit(dir .. '/smoke.css')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { 'body { color: #ff0000; }' })
  require('colorizer').attach_to_buffer(0)
  local color_namespace = require('colorizer.constants').namespace.default
  check(#vim.api.nvim_buf_get_extmarks(0, color_namespace, 0, -1, {}) > 0, 'color preview renders highlights')
  vim.bo.modified = false

  local before_right, before_below = vim.o.splitright, vim.o.splitbelow
  local initial_window = vim.api.nvim_get_current_win()
  vim.api.nvim_feedkeys(' sl', 'xt', false)
  check(vim.o.splitright == before_right and vim.o.splitbelow == before_below, 'split shortcut preserves preferences')
  check(
    vim.api.nvim_win_get_position(0)[2] < vim.api.nvim_win_get_position(initial_window)[2],
    'split shortcut opens left'
  )
  vim.cmd.close()

  local yazi = require('yazi')
  local open = yazi.yazi
  local opened
  yazi.yazi = function(_, path)
    opened = path
  end
  vim.cmd.edit(dir)
  check(
    vim.wait(1000, function()
      return opened ~= nil
    end),
    'directory edit reaches Yazi'
  )
  check(vim.uv.fs_realpath(opened) == vim.uv.fs_realpath(dir), 'Yazi receives requested directory')
  yazi.yazi = open
  vim.fn.delete(dir, 'rf')

  require('telescope').load_extension('fzf')
  check(true, 'Telescope native fzf extension loads')
  for _, server in ipairs({
    'jdtls',
    'pyright',
    'gopls',
    'rust_analyzer',
    'html',
    'ts_ls',
    'cssls',
    'jsonls',
    'bashls',
    'lua_ls',
  }) do
    check(vim.lsp.is_enabled(server), 'LSP enabled: ' .. server)
  end
  print('All smoke checks passed')
end

local ok, err = xpcall(run, debug.traceback)
if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd('cquit 1')
else
  vim.cmd('qa!')
end
