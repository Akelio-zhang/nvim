:set number
:set guicursor=i:block
syntax on

set rtp+=/opt/homebrew/opt/fzf

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes
" theme
Plug 'folke/tokyonight.nvim'

" Shorthand notation for GitHub; translates to https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/seoul256.vim.git'

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Use 'dir' option to install plugin in a non-default directory
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }

" Post-update hook: run a shell command after installing or updating the plugin
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Post-update hook can be a lambda expression
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" If the vim plugin is in a subdirectory, use 'rtp' option to specify its path
Plug 'nsf/gocode', { 'rtp': 'vim' }

" On-demand loading: loaded when the specified command is executed
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" On-demand loading: loaded when a file with a specific file type is opened
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" (Use nvim-treesitter instead) Just justfile plugin
" Plug 'NoahTheDuke/vim-just'

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Call plug#end to update &runtimepath and initialize the plugin system.
" - It automatically executes `filetype plugin indent on` and `syntax enable`
call plug#end()

" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" https://github.com/folke/tokyonight.nvim
colorscheme tokyonight-night

" -----------------------------------------------------------------
"                                                                 -
" load plugin config in lua/plugins                               -
"                                                                 -
" -----------------------------------------------------------------
lua << EOF
require('core.disabled')
-- require('core.options')
require('core.keymaps')
require('core.autocmds')
require('core.lazy')
EOF
