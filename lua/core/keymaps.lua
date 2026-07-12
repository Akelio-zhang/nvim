local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- remap
keymap('n', 's', '<Cmd>w<CR>', opts)
keymap('n', 'S', '<Cmd>wq<CR>', opts)
keymap({ 'n', 'v' }, 'K', '5k', opts)
keymap({ 'n', 'v' }, 'J', '5j', opts)
keymap({ 'n', 'v' }, 'H', '0', opts)
keymap({ 'n', 'v' }, 'L', '$', opts)
keymap('n', 'n', 'nzz', opts)
keymap('n', 'N', 'Nzz', opts)
keymap('n', '<SPACE>nh', '<Cmd>nohlsearch<CR>', opts)
keymap('n', '<SPACE>ev', '<Cmd>e $MYVIMRC<CR>', opts)
keymap('n', '<SPACE>sp', '<Cmd>NvimLazyProfile<CR>', opts)
keymap('n', '<SPACE>sh', '<Cmd>NvimHealth<CR>', opts)
keymap('n', '<SPACE>ss', '<Cmd>NvimStartupReport<CR>', opts)
keymap('n', '<SPACE>sj', '<Cmd>set splitbelow<CR><Cmd>split<CR>', opts)
keymap('n', '<SPACE>sl', '<Cmd>set nosplitright<CR><Cmd>vsplit<CR>', opts)
keymap('n', '<SPACE><SPACE>', '<Esc>/<++><CR><Cmd>nohlsearch<CR>c4l', opts)
keymap('n', '<SPACE>pp', '"+p', opts)
keymap('v', '<SPACE>yc', '"+y', opts)

-- lsp diagnostic
keymap('n', '<SPACE>dt', vim.diagnostic.open_float, opts)
keymap('n', '<SPACE>dp', vim.diagnostic.goto_prev, opts)
keymap('n', '<SPACE>dn', vim.diagnostic.goto_next, opts)
keymap('n', '<SPACE>dl', vim.diagnostic.setloclist, opts)
keymap({ 'n', 'v' }, '<SPACE>cf', function()
  local ok, conform = pcall(require, 'conform')
  if ok then
    conform.format({ async = true, lsp_fallback = true })
  end
end, opts)

-- telescope
keymap('n', '<SPACE>ff', '<Cmd>Telescope find_files<CR>', opts)
keymap('n', '<SPACE>fh', '<Cmd>Telescope find_files search_dirs=~<CR>', opts)
keymap('n', '<SPACE>fg', '<Cmd>Telescope git_files<CR>', opts)
keymap('n', '<SPACE>fo', '<Cmd>Telescope oldfiles<CR>', opts)
keymap('n', '<SPACE>fb', '<Cmd>Telescope buffers<CR>', opts)
keymap('n', '<SPACE>fl', '<Cmd>Telescope live_grep<CR>', opts)
keymap('n', '<SPACE>fd', '<Cmd>Telescope diagnostics<CR>', opts)
keymap('n', '<SPACE>fp', '<Cmd>Telescope resume<CR>', opts)
keymap('n', '<SPACE>ft', '<Cmd>TodoTelescope<CR>', opts)

-- lazygit
keymap('n', '<SPACE>gg', '<Cmd>LazyGit<CR>', opts)

-- gitsigns - hunk
keymap('n', '<SPACE>hl', '<Cmd>Gitsigns preview_hunk<CR>', opts)
keymap('n', '<SPACE>hn', '<Cmd>Gitsigns next_hunk<CR>', opts)
keymap('n', '<SPACE>hp', '<Cmd>Gitsigns prev_hunk<CR>', opts)
keymap('n', '<SPACE>hr', '<Cmd>Gitsigns reset_hunk<CR>', opts)

-- table-mode
keymap('n', '<M-T>', '<Cmd>TableModeToggle<CR>', opts)
keymap('n', '<M-R>', '<Cmd>TableModeRealign<CR>', opts)
