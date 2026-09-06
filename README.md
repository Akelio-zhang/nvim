# Neovim Config

基于 `lazy.nvim` 的模块化配置，核心语言栈：`Java / Python / Go / Rust / HTML / JS`。

## 快速开始

环境要求：Neovim 0.12+、Git、C 编译器、`tree-sitter` CLI、`rg`。
文件管理和 Git 界面还需要 `yazi`、`lazygit`，图标需要 Nerd Font。

1. 启动 Neovim 后执行 `:Lazy sync`
2. 执行 `:Mason` 确认语言服务器已安装
3. 前端格式化安装 `bun add --global prettier`，确保 Bun 的 bin 目录在 PATH 中；也可以在项目中使用 `bun add --dev prettier`
4. 按使用的语言准备 `stylua`、`ruff`、`google-java-format`、`goimports`、`gofmt`、`rustfmt`；Mason 的 LSP 安装不会自动安装这些格式化器
5. 执行 `:ConformInfo` 和 `:checkhealth` 排查环境问题

Treesitter 在首次启动时异步安装配置中的解析器，完成后会自动为已打开的
受支持文件启用高亮和缩进。Shell、JSX、TypeScript/TSX、Markdown 均已覆盖。
`nvim .` 和 `:edit <目录>` 会交给 Yazi 打开。

保存文件时自动格式化；前端优先运行可用的 `prettierd`，否则运行 `prettier`，
不会重复执行两者。外部格式化器不可用时，只能回退到支持格式化的 LSP。

## 常用快捷键

### 文件与检索（Telescope / Yazi）

- `<space>ff`：查找文件
- `<space>fg`：Git 文件
- `<space>fl`：全文检索
- `<space>fb`：Buffer 列表
- `<space>fo`：最近文件
- `<space>fd`：诊断列表
- `<space>fp`：恢复上次 Telescope 会话
- `<space>ya`：在当前文件位置打开 Yazi
- `<space>yd`：在工作目录打开 Yazi

### LSP / 诊断 / 格式化

- `<space>gd`：跳转定义
- `<space>gr`：查找引用
- `<space>gk`：悬停文档
- `<space>rn`：重命名符号
- `<space>ca`：代码操作
- `<space>dt`：当前诊断浮窗
- `<space>dp` / `<space>dn`：上一个 / 下一个诊断
- `<space>dl`：诊断写入 location list
- `<space>cf`：格式化（`conform`，可回退到 LSP）

### Git

- `<space>gg`：打开 LazyGit
- `<space>hl`：预览当前 hunk
- `<space>hn` / `<space>hp`：下一个 / 上一个 hunk
- `<space>hr`：重置当前 hunk

### Markdown

- `<M-T>`：表格模式开关（table-mode）
- `<M-R>`：表格重排
- `:MarkdownPreview`：打开 Markdown 实时预览

### 性能与健康检查

- `<space>sp`：打开 `:Lazy profile`
- `<space>sh`：运行 `:checkhealth`
- `<space>ss`：显示启动耗时统计

安装好依赖和解析器后，可在配置目录运行回归检查：

```sh
nvim --headless -i NONE '+luafile tests/smoke.lua'
```

检查会使用临时文件验证高亮、保存格式化、颜色预览、分屏、目录路由及 LSP 启用状态。

## 插件功能索引

### UI

- `folke/tokyonight.nvim`：主题
- `goolord/alpha-nvim`：启动页
- `nvim-lualine/lualine.nvim`：状态栏
- `lukas-reineke/indent-blankline.nvim`：缩进指示

### 编辑与导航

- `nvim-telescope/telescope.nvim` + `telescope-fzf-native.nvim`：检索
- `mikavilpas/yazi.nvim`：文件管理
- `windwp/nvim-autopairs`：自动补全括号
- `windwp/nvim-ts-autotag`：HTML/JSX 标签补全
- `catgoose/nvim-colorizer.lua`：颜色预览
- `junegunn/vim-easy-align`：对齐文本

### LSP 与补全

- `mason.nvim` + `mason-lspconfig.nvim`：LSP 安装管理
- `nvim-lspconfig`：LSP 客户端配置
- `saghen/blink.cmp`：补全引擎
- `L3MON4D3/LuaSnip` + `friendly-snippets`：片段
- `j-hui/fidget.nvim`：LSP 状态提示

### 代码与 Git

- `nvim-treesitter`：语法高亮和语法树
- `stevearc/conform.nvim`：格式化框架
- `lewis6991/gitsigns.nvim`：Git 标记
- `kdheepak/lazygit.nvim`：Git TUI
- `folke/todo-comments.nvim`：TODO/FIXME 跳转
- `numToStr/Comment.nvim`：注释

### Markdown / 其他

- `iamcco/markdown-preview.nvim`：Markdown 预览
- `dhruvasagar/vim-table-mode`：Markdown 表格编辑
- `ferrine/md-img-paste.vim`：粘贴图片
- `wakatime/vim-wakatime`：编码时长统计

### Credits

- https://github.com/gin-18/nvim
