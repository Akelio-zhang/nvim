# Changelog

All notable changes to this Neovim configuration are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## How this is versioned

- The current version lives in [`VERSION`](./VERSION) and is mirrored by a git tag
  `v<x.y.z>` on the release commit.
- The alpha dashboard footer and `:ConfigVersion` command both read `VERSION`,
  so they always reflect the checked-out version.
- **Rollback / review**: `git checkout v<x.y.z>` restores that version's config;
  `git tag` lists all releases.

### Releasing a new version

1. As you make changes, add entries under `[Unreleased]` below.
2. When ready to cut a release:
   - Move the `[Unreleased]` entries into a new `## [x.y.z] - YYYY-MM-DD` section.
   - Update `VERSION` to `x.y.z`.
   - Commit, then `git tag -a vx.y.z -m "Release vx.y.z"`.
3. Bump rules:
   - **patch** `0.0.x` — bug fixes, typo corrections, no behavior change.
   - **minor** `0.x.0` — new plugin / feature / config enhancement.
   - **major** `x.0.0` — breaking change or large refactor.

> Pre-versioning history (before v0.1.0) lives in the git log and
> `NVIM_AUDIT_AND_PLAN.md`.

## [Unreleased]

_Nothing yet._

## [0.3.0] - 2026-09-06

### Added
- A repeatable headless smoke test for syntax highlighting, save formatting,
  formatter selection, color previews, directory routing, splits and LSP enablement.

### Changed
- Migrate color previews to the maintained `catgoose/nvim-colorizer.lua` fork,
  loaded on buffer read/creation, eliminating the old deprecated API call.
- Added TypeScript, TSX, Markdown and inline Markdown parsers; parser installation
  now attaches highlighting and indentation to existing buffers when it completes.
- Load Yazi at startup to handle directory arguments and `:edit <directory>`.
- Load Conform on buffer read/creation so save formatting is ready before the
  `VeryLazy` event, and use the current `lsp_format` fallback option.
- Use `vim.diagnostic.jump` for previous/next diagnostic navigation.
- Preserve existing lockfile updates for gitsigns, mason-lspconfig, nvim-lspconfig,
  nvim-web-devicons and yazi in the tested release.
- Document runtime tools, Prettier installation and formatter availability checks;
  refresh the configuration audit and correct the Yazi shortcuts.

### Fixed
- Resolve filetypes to parser names before enabling Tree-sitter, including `sh`
  (Bash) and `javascriptreact` (JSX).
- Run only the first available frontend formatter instead of running both
  prettierd and prettier in sequence.
- Keep directional split shortcuts from changing global split preferences.

### Removed
- Global `vim.tbl_flatten` override that incorrectly flattened only one level.

## [0.2.0] - 2026-07-25

### Changed
- Migrated `nvim-treesitter` from the legacy `master` branch to `main`, using
  its Neovim 0.12 API and installing parsers and queries under the user data
  directory.
- Tree-sitter now loads eagerly, installs the configured language parsers, and
  enables native highlighting and indentation on matching filetypes.

### Fixed
- Replaced the removed `nvim_treesitter#foldexpr()` with Neovim's native
  Tree-sitter fold expression.
- Resolved the Tree-sitter highlighter `node:range()` nil error on Neovim
  0.12 by aligning the plugin branch and installed parsers with the editor API.

## [0.1.0] - 2026-07-12

First tagged release. Captures the configuration after the LSP / plugin /
entry-point cleanup.

### Added
- Version tracking: `VERSION` file, this `CHANGELOG.md`, `:ConfigVersion`
  command, and alpha dashboard footer version display.
- `lazydev.nvim` replacing the deprecated `neodev.nvim` (lua_ls Neovim runtime
  typing).
- `stylua` and `goimports` formatters installed, so `format_on_save` now works
  for Lua and Go (previously the configured formatters were missing).

### Changed
- Entry point migrated from `init.vim` to `init.lua`.
- LSP servers are now started by `mason-lspconfig`'s `automatic_enable`; the
  redundant manual `vim.lsp.enable` loop was removed.
- Mason bin is prepended to `PATH` via mason's `PATH = 'prepend'` option,
  replacing a manual `vim.env.PATH` hack.
- `indent-blankline` is lazy-loaded on `BufReadPost`.
- `nvim.log` is no longer tracked in git (gitignored).

### Fixed
- `rust_analyzer` setting `checkOnsave` → `checkOnSave` (casing typo; check-on-
  save with clippy now actually applies).

### Removed
- `autochdir` (broke project-wide telescope / gitsigns / lazygit scope).
- `vim-fireplace` (Clojure) and the `~/my-prototype-plugin` entry (unused).
- Redundant `<space>ee` yazi mapping (use `<space>ya`).
