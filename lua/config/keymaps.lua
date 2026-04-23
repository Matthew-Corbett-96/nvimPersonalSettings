-- ================================================================================================
-- KEYMAPS
-- ================================================================================================

-- Page Navigation
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { desc = "full page down (centered)" })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { desc = "full page up (centered)" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- TODO: Add keymaps for Telescope, LSPs, and gitsigns

-- gitsigns
-- key map for hp to preview hunk
-- key map for hd to view div

-- whichkey
-- keymap for telescope combined with git
-- keymap for telescope and LSP
-- keymap for grepping files
-- keymap for color picker

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
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

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
