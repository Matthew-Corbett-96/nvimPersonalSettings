-- ============================================================================
-- OPTIONS
-- ============================================================================

-- =====================================================================
--  Cross-Platform Clipboard & Shell
-- =====================================================================
local is_windows = vim.fn.has('win32') == 1
local is_linux = vim.fn.has('unix') == 1
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

-- Undo Tree
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.backup = false      -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false    -- do not create a swapfile
vim.opt.undofile = true     -- do create an undo file
vim.opt.undodir = undodir   -- set the undo directory

-- Viewport
vim.opt.number = true             -- line number
vim.opt.relativenumber = true     -- relative line numbers
vim.opt.cursorline = true         -- highlight current line
vim.opt.wrap = false              -- do not wrap lines by default
vim.opt.scrolloff = 15            -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 15        -- keep 10 lines to left/right of cursor
vim.opt.signcolumn = "yes"        -- always show a sign column
vim.opt.colorcolumn = "100"       -- show a column at 100 position chars
vim.opt.showmatch = true          -- highlights matching brackets
vim.opt.showmode = false          -- do not show the mode, instead have it in statusline
vim.opt.conceallevel = 0          -- do not hide markup
vim.opt.concealcursor = ""        -- do not hide cursorline in markup
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines
-- cursor blinking and settings
vim.opt.guicursor =
"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Tabs
vim.opt.tabstop = 2        -- tabwidth
vim.opt.shiftwidth = 2     -- indent width
vim.opt.softtabstop = 2    -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true   -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true  -- copy indent from current line

-- Performance
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.o.redrawtime = 10000               -- increase neovim redraw tolerance
vim.o.maxmempattern = 20000            -- increase max memory
vim.opt.updatetime = 300               -- faster completion
vim.opt.timeoutlen = 500               -- timeout duration
vim.opt.ttimeoutlen = 0                -- key code timeout
vim.opt.autoread = true                -- auto-reload changes if outside of neovim
vim.opt.autowrite = false              -- do not auto-save
vim.opt.lazyredraw = true              -- do not redraw during macros
-- vim.opt.synmaxcol = 300                           -- syntax highlighting limit

-- In File Search
vim.opt.ignorecase = true     -- case insensitive search
vim.opt.smartcase = true      -- case sensitive if uppercase in string
vim.opt.hlsearch = true       -- highlight search matches
vim.opt.incsearch = true      -- show matches as you type
vim.opt.path:append("**")     -- include subdirs in search
vim.opt.iskeyword:append("-") -- include - in words

-- Command Line
vim.o.wildmenu = true -- tab completion
-- complete longest common match, full completion list, cycle through with Tab
vim.opt.wildmode = "longest:full,full"
vim.opt.cmdheight = 1                             -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.pumheight = 10                            -- popup menu height
vim.opt.pumblend = 10                             -- popup menu transparency
vim.opt.winblend = 0                              -- floating window transparency

-- Misc
vim.opt.splitbelow = true              -- horizontal splits go below
vim.opt.splitright = true              -- vertical splits go right
vim.opt.hidden = true                  -- allow hidden buffers
vim.opt.errorbells = false             -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.autochdir = true               -- autochange directories
vim.opt.selection = "inclusive"        -- include last char in selection
vim.opt.mouse = "a"                    -- enable mouse support
vim.opt.modifiable = true              -- allow buffer modifications
vim.opt.encoding = "utf-8"             -- set encoding
