# Neovim 配置现状与优化计划

更新时间：2026-03-04

## 1. 当前配置结构

- 启动入口：`init.vim`
- 插件管理：`vim-plug` 与 `lazy.nvim` 混用
- `lua/core/*`：基础设置、快捷键、自动命令、内置模块禁用
- `lua/plugins/*`：按功能拆分的 lazy 插件定义（ui/editor/lsp/cmp/coding/markdown）

## 2. 当前插件概览（lazy-lock 锁定）

共 36 个 lazy 插件，核心分组如下：

- UI：`alpha-nvim`、`lualine.nvim`、`indent-blankline.nvim`
- 文件与检索：`yazi.nvim`、`telescope.nvim`、`telescope-fzf-native.nvim`
- Git：`lazygit.nvim`、`gitsigns.nvim`
- 语法与编辑增强：`nvim-treesitter`、`nvim-autopairs`、`nvim-ts-autotag`、`Comment.nvim`、`todo-comments.nvim`、`nvim-colorizer.lua`
- LSP 与补全：`nvim-lspconfig`、`nvim-cmp`、`LuaSnip`、`cmp-*`、`lspkind.nvim`、`cmp-tabnine`
- 格式化：`conform.nvim`
- Markdown：`markdown-preview.nvim`、`vim-table-mode`、`md-img-paste.vim`
- 其他：`vim-wakatime`

另有 `vim-plug` 插件在 `init.vim` 中仍在加载（如 `tokyonight`、`nerdtree`、`vim-go` 等）。

## 3. 已识别问题

### 高优先级（影响可用性）

- `core.options` 未加载，`lua/core/options.lua` 设置不生效。
- `core.disabled` 禁用了 `syntax` 与 `ftplugin`，可能导致高亮与文件类型行为异常。
- LSP 仅有 UI/按键与诊断配置，未配置实际 language server 的 `setup()`。
- 部分快捷键指向未安装或未启用能力（`<space>ee`、`<space>fp`）。

### 中优先级（体验与稳定性）

- Telescope 选项拼写错误：`layout_stratgy`。
- `nvim-cmp` 配置了 `treesitter` source 但未安装 `cmp-treesitter`。
- LSP 诊断浮窗 autocmd 逻辑有重复定义。

### 低优先级（维护性）

- 同时维护 `vim-plug` 与 `lazy.nvim`，维护成本和冲突风险偏高。
- `init.vim` 与 Lua 选项存在重复/冲突（如缩进设置 4 vs 2）。

## 4. 优化路线（分阶段）

### Phase 1（已开始，低风险）

- [x] 启用 `core.options`
- [x] 修复失效 keymap 与 dashboard 中不存在命令
- [x] 修复 Telescope 拼写错误
- [x] 清理 `nvim-cmp` 无效 source
- [x] 保留基础能力前提下，恢复 `syntax/ftplugin`
- [x] 增加基础 LSP server setup（按已安装 server 自动生效）

### Phase 2（建议下一步）

- 将 `vim-plug` 插件逐项迁移到 `lazy.nvim`
- 完成后移除 `plug#begin/plug#end` 块，实现单一插件管理

### Phase 3（增强）

- 引入 `mason.nvim + mason-lspconfig` 管理 LSP 安装与自动配置
- 细化 `conform` 与 LSP 的职责边界（格式化统一走 conform）
- 增加启动与加载性能检查（`:Lazy profile`、`:checkhealth`）
