return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup {}
    end
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {},
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          "ts_ls",
          "angularls",
          "html",
          "cssls",
          "pyright",
          "sqlls",
          "lua_ls"
        }
      }
    end
  },
  --   vim.lsp.config("lua_ls", {
  --     settings = {
  --       Lua = {
  --         diagnostics = { globals = { "vim" } },
  --         telemetry = { enable = false },
  --       },
  --     },
  --   })
  -- end
}
