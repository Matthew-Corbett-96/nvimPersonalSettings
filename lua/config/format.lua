-- =====================================================================
-- Formatting Logic (conform.nvim)
-- =====================================================================
require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    html = { "prettier" },
    scss = { "prettier" },
    python = { "black" },
  },
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
})
