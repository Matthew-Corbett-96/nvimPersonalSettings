-- =====================================================================
-- 1. OS Detection & Core Settings
-- =====================================================================
local is_windows = vim.fn.has('win32') == 1
local is_linux = vim.fn.has('unix') == 1

vim.g.mapleader = ' '
vim.g.localleader = ' '

require('config.options')


-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr"                          -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})
vim.opt.foldlevel = 99 -- start with all folds open


-- =====================================================================
--  Cross-Platform Clipboard & Shell
-- =====================================================================
if is_windows then
  vim.opt.clipboard = 'unnamedplus'
elseif is_linux then
  vim.opt.clipboard = 'unnamedplus'
  -- Wayland support (requires wl-clipboard package on Arch)
  vim.g.clipboard = {
    name = 'wl-clipboard',
    copy = { ['+'] = 'wl-copy', ['*'] = 'wl-copy' },
    paste = { ['+'] = 'wl-paste', ['*'] = 'wl-paste' },
  }
end

-- ================================================================================================
-- KEYMAPS
-- ================================================================================================

-- Page Navigation
vim.keymap.set('n', '<leader>e', ":Explore<CR>", { desc = 'File explorer' })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Quality of Life
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

require('config.lazy')


-- =====================================================================
-- 4. Formatting Logic (conform.nvim)
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

-- =====================================================================
-- Diagnostic Configuration
-- =====================================================================
vim.diagnostic.config({
  -- This brings back the inline error messages
  virtual_text = {
    prefix = '■', -- You can change this to '●', '▎', or leave it blank
    source = "if_many", -- Shows the source (e.g., Pyright, Angular) if there's more than one
  },
  -- Show signs in the gutter (next to line numbers)
  signs = true,
  -- Underline the actual code that has the error
  underline = true,
  -- Keep the errors sorted by severity (Errors first, then Warnings)
  severity_sort = true,
  -- Don't update diagnostics while you're still typing (prevents flickering)
  update_in_insert = false,
})

-- =====================================================================
-- 5. Keybindings
-- =====================================================================
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

-- 1. Search only in Angular/TS/HTML/SCSS files
vim.keymap.set('n', '<leader>fw', function()
  builtin.find_files({
    prompt_title = "Web Stack Search",
    search_dirs = { "src" },
    find_command = { "fd", "--type", "f", "-e", "ts", "-e", "html", "-e", "scss", "-e", "js" }
  })
end, { desc = "Search Web Files" })

-- 2. Search only in Python files
vim.keymap.set('n', '<leader>fp', function()
  builtin.find_files({
    prompt_title = "Python Search",
    find_command = { "fd", "--type", "f", "-e", "py" }
  })
end, { desc = "Search Python Files" })

-- 3. Live Grep restricted to a specific file type (e.g., only search code inside TS files)
vim.keymap.set('n', '<leader>ft', function()
  builtin.live_grep({
    type_filter = "typescript",
    prompt_title = "Grep TypeScript Only"
  })
end, { desc = "Grep in TS files" })

-- Quick jump to your NeoVim config
vim.keymap.set('n', '<leader>fc', function()
  builtin.find_files({
    cwd = vim.fn.stdpath("config"),
    prompt_title = "NeoVim Config"
  })
end, { desc = "Edit NeoVim Config" })

-- Search for TODO, FIXME, or HACK across the project
vim.keymap.set('n', '<leader>ft', function()
  builtin.live_grep({
    prompt_title = "Project TODOs",
    default_text = "TODO:|FIXME:|HACK:",
    -- This tells ripgrep to treat the search as a Regular Expression
    vimgrep_arguments = {
      'rg', '--color=never', '--no-heading', '--with-filename',
      '--line-number', '--column', '--smart-case', '--pcre2'
    },
  })
end, { desc = "Find TODOs" })

-- Browse and live-preview colorschemes
vim.keymap.set('n', '<leader>th', function()
  builtin.colorscheme({ enable_preview = true })
end, { desc = "Switch Theme" })
