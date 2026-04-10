return {
  -- UI & Theme
  { "ellisonleao/gruvbox.nvim", priority = 1000,     config = true },
  { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },
  { -- LSP support
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "angularls", "html", "cssls", "pyright", "sqlls", "lua_ls" }
      })
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
          },
        },
      })
      local servers = {
        "ts_ls", "angularls",
        "html", "cssls",
        "pyright", "sqlls", "lua_ls"
      }
      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end
    end
  },

  -- Formatter
  { "stevearc/conform.nvim" },
}
