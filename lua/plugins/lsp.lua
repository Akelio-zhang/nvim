return {
  -- mason
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    opts = {},
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
      { 'folke/neodev.nvim', opts = {} },
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      local icons = require('plugins.config.icons').diagnostic_icons

      -- diagnostic
      vim.diagnostic.config({
        virtual_text = false,
        float = { border = 'rounded' },
      })

      -- set signs
      local signs = {
        Error = icons.error,
        Warn = icons.warn,
        Hint = icons.hint,
        Info = icons.info,
      }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          local opts = { buffer = ev.buf }
          vim.keymap.set('n', '<space>gk', vim.lsp.buf.hover, opts)
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
      local mason_bin = vim.fn.stdpath('data') .. '/mason/bin'
      if not string.find(':' .. vim.env.PATH .. ':', ':' .. mason_bin .. ':', 1, true) then
        vim.env.PATH = mason_bin .. ':' .. vim.env.PATH
      end

      vim.lsp.config('*', {
        capabilities = capabilities,
        handlers = {
          ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
          ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
        },
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
            },
          },
        },
      })

      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = 'clippy' },
          },
        },
      })

      local enable_servers = {
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
      }

      for _, server in ipairs(enable_servers) do
        pcall(vim.lsp.enable, server)
      end
    end,
  },
}
