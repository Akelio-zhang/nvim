-- Version helpers for the Neovim config.
-- Source of truth: VERSION file + git tags (v<x.y.z>). See CHANGELOG.md.
local M = {}

local config_dir = vim.fn.stdpath('config')

---Return the current config version (read from the VERSION file, cached).
---@return string
function M.version()
  if M._version then
    return M._version
  end
  local lines = vim.fn.readfile(config_dir .. '/VERSION')
  M._version = (lines and lines[1] or '0.0.0'):gsub('%s+', '')
  return M._version
end

---Return the top two changelog sections ([Unreleased] + latest release).
---@return string
function M.recent_changes()
  local lines = vim.fn.readfile(config_dir .. '/CHANGELOG.md')
  if not lines then
    return ''
  end
  local out, sections = {}, 0
  for _, line in ipairs(lines) do
    if line:match('^## %[') then
      sections = sections + 1
      if sections > 2 then
        break
      end
    end
    if sections >= 1 then
      out[#out + 1] = line
    end
  end
  return vim.trim(table.concat(out, '\n'))
end

vim.api.nvim_create_user_command('ConfigVersion', function()
  local msg = string.format('Ake-Neovim v%s\n\n%s', M.version(), M.recent_changes())
  vim.notify(msg, vim.log.levels.INFO, { title = 'Config Version' })
end, { desc = 'Show Neovim config version and recent changes' })

return M
