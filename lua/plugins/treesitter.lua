return { -- Syntax Highlighting
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "angular",
      "html",
      "css",
      "javascript",
      "typescript",
      "html",
      "css",
      "scss",
      "python",
      "sql",
      "lua",
      "vim",
      "vimdoc"
    },
    highlight = {
      enabled = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
  },
}
