# Neovim 配置审计

更新时间：2026-09-06 · 配置版本：0.3.0

## 当前结构

- 入口：`init.lua`；插件管理：`lazy.nvim`，33 个插件。
- `lua/core/`：选项、按键、自动命令、启动统计和版本信息。
- `lua/plugins/`：按 UI、编辑、LSP、补全、代码和 Markdown 分类。
- 语言服务器由 Mason 安装，通过 `vim.lsp.config` 配置并自动启用。
- 补全使用 Blink + LuaSnip；保存和手动格式化统一使用 Conform。

## 0.3.0 修复

- Treesitter 区分文件类型和解析器名称，覆盖 Shell、JSX、TypeScript/TSX。
- 增加 Markdown 解析器，并在异步安装后为已打开的文件重新启用 Treesitter。
- 前端格式化器使用首个可用工具，避免重复执行。
- 移除改变递归展开行为的全局 `vim.tbl_flatten` 补丁。
- 将颜色预览迁移到维护中的 `catgoose/nvim-colorizer.lua`，消除旧插件的弃用调用。
- Yazi 启动时加载，接管目录浏览入口。
- 分屏快捷键使用局部方向修饰符，不再修改全局分屏选项。
- 诊断跳转及格式化回退改用当前 API，更新环境准备说明和按键文档。

## 后续按需优化

- 用交互会话的 `:Lazy profile` 判断是否需要进一步细分 `VeryLazy` 插件；
  headless 启动统计不能代表完整交互启动时间。
- 在实际 Java、Go、Rust、Python 项目中按需求调整 LSP；注册启用不等于
  每种语言在每个项目中都已通过集成测试。
- 大文件出现卡顿时，再为 Treesitter、颜色预览和保存格式化增加大小阈值。
- 保留当前个人按键习惯；`s/S/H/J/K/L` 覆盖原生操作是有意配置。

## 环境检查说明

使用 `:ConformInfo` 查看当前文件真正可用的格式化器，使用 `:checkhealth`
检查外部依赖。Prettier 可通过 Bun 全局安装或安装在项目中；可选的 prettierd
未安装不影响 Prettier 工作。现有插件没有 LuaRocks 依赖，因此其缺失不阻止使用。
