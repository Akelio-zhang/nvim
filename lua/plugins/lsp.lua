return {
  -- mason
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    opts = { PATH = 'prepend' },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    event = 'VeryLazy',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = {
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
      },
      automatic_enable = true,
    },
  },

  -- lsp core
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      { 'folke/lazydev.nvim', opts = {} },
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      local icons = require('plugins.config.icons').diagnostic_icons

      -- diagnostic
      vim.diagnostic.config({
        virtual_text = false,
        float = { border = 'rounded' },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.error,
            [vim.diagnostic.severity.WARN] = icons.warn,
            [vim.diagnostic.severity.HINT] = icons.hint,
            [vim.diagnostic.severity.INFO] = icons.info,
          },
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          local opts = { buffer = ev.buf }
          vim.keymap.set('n', '<space>gk', function()
            vim.lsp.buf.hover({ border = 'rounded' })
          end, opts)
          vim.keymap.set('n', '<space>gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', '<space>gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

          local client = ev.data and vim.lsp.get_client_by_id(ev.data.client_id)
          if vim.lsp.inlay_hint and client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
          end
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
            completion = { callSnippet = 'Replace' },
          },
        },
      })

      vim.lsp.config('jdtls', {
        root_markers = {
          '.git',
          'mvnw',
          'gradlew',
          'pom.xml',
          'build.gradle',
          'build.gradle.kts',
          'settings.gradle',
          'settings.gradle.kts',
        },
      })

      vim.lsp.config('gopls', {
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'standard',
              autoImportCompletions = true,
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'openFilesOnly',
            },
            completion = {
              completeFunctionParens = true,
            },
          },
        },
      })

      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            checkOnSave = true,
            check = { command = 'clippy' },
          },
        },
      })

      -- Servers are started by mason-lspconfig's `automatic_enable`, which
      -- calls vim.lsp.enable for each installed server after the vim.lsp.config
      -- calls above have registered their settings.
    end,
  },
}
