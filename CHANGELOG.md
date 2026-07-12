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
