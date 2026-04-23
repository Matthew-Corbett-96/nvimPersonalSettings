-- lua/config/lsp.lua

-- =====================================================================
-- Diagnostic Configuration Overrides
-- =====================================================================
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config('ts_ls', {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})

-- =====================================================================
-- Diagnostic Configuration
-- =====================================================================
vim.diagnostic.config({
  virtual_text = { -- This brings back the inline error messages
    spacing = 2,
    prefix = '●', -- You can change this to '●', '▎', or leave it blank
    source = "if_many", -- Shows the source (e.g., Pyright, Angular) if there's more than one
  },
  float = {
    border = 'rounded',
    source = 'if_many',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '■',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.INFO] = '●',
      [vim.diagnostic.severity.HINT] = 'H',
    },
  },
  underline = true,
  severity_sort = true,
  update_in_insert = false,
})

-- =====================================================================
-- Keymaps (only availible if there is a LSP attached to buffer
-- =====================================================================
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map('n', 'K', vim.lsp.buf.hover, 'LSP Hover')
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
    map('n', 'gr', vim.lsp.buf.references, 'References')
    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('n', '<leader>l', function()
      vim.lsp.buf.format({ async = true })
    end, 'Format buffer')
  end,
})
