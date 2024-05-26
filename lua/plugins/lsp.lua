return {
  -- lsp installation

  -- lsp
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      local lspconfig = require('lspconfig')
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
        end,
      })

      -- border for float win
      require('lspconfig.ui.windows').default_options.border = 'rounded'
      local handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
        ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
      }

      -- float diagnostic under cursor
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = vim.api.nvim_create_augroup('float_diagnostic', { clear = true }),
        callback = function()
          vim.diagnostic.open_float(nil, { focus = false })
        end,
      })

      -- autocompletion
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- on attch
      local on_attach = function(client, bufnr)
        -- float diagnostic under cursor
        vim.api.nvim_create_autocmd('CursorHold', {
          buffer = bufnr,
          callback = function()
            local opts = {
              focusable = false,
              close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
              border = 'rounded',
              source = 'always',
              prefix = ' ',
              scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
          end,
        })

        -- highlight symbol under cursor
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_augroup('lsp_document_highlight', {
            clear = false,
          })
          vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = 'lsp_document_highlight',
          })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.document_highlight()
            end,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.clear_references()
            end,
          })
        end
      end

      local servers = {
        'clangd',
        'vimls',
        'html',
        'cssls',
        'jsonls',
        'tailwindcss',
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      -- lua
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        handlers = handlers,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })
    end,
  },
}
