return { -- Syntax Highlighting
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "angular",
      "css",
      "html",
      "javascript",
      "lua",
      "python",
      "scss",
      "sql",
      "typescript",
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
