-- ============================
-- Basic settings configuration
-- ============================
vim.opt.compatible = false          -- Vi compatibility
vim.opt.syntax = "on"               -- Syntax highlighting
vim.cmd("filetype on")              -- Filetype detection
vim.cmd("filetype indent on")       -- Auto indentation
if vim.fn.has("win32") == 1 then
  vim.opt.shell = "ash"
  vim.opt.fileformat = "dos"
else
  vim.opt.fileformat = "unix"
end

-- =================================
-- Appearance and interface settings
-- =================================
vim.opt.signcolumn = "yes"
vim.opt.background = "dark"         -- Background color
vim.opt.termguicolors = true        -- True color support
vim.opt.laststatus = 1              -- Show the status line or not
if vim.fn.has("gui_running") == 1 then
  vim.opt.guifont = "Inconsolata LGC Nerd Font:h7:b"
  vim.opt.guicursor = {
    "n-v-sm:block-Cursor",
    "i-c-ci-ve:hor10-Cursor",
    "r-cr-o:hor10-Cursor",
    "t:ver20-Cursor",
    -- default: set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
  }
  if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_no_idle = true
    vim.g.neovide_title_background_color = "#0e1415"
    vim.g.neovide_cursor_animation_length = 0.06
    vim.g.neovide_cursor_short_animation_length = 0.04
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_cursor_trail_size = 1
  end
else
  vim.opt.guicursor = {
    "n-v-sm:block-Cursor",
    "i-c-ci-ve:hor20-Cursor",
    "r-cr-o:hor20-Cursor",
    "t:hor20-Cursor",
    -- default: set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
  }
end

-- =====================================
-- Clipboard and autocompletion settings
-- =====================================
vim.opt.clipboard = "unnamedplus"   -- Set clipboard to use the system clipboard
vim.opt.complete:append("d")        -- Enable auto completion for C/C++ macros

-- ============================
-- Tab and indentation settings
-- ============================
vim.opt.expandtab = true          -- Convert tab to spaces

-- ===============
-- Search settings
-- ===============
vim.opt.hlsearch = true           -- Highlight search matches
vim.opt.ignorecase = true         -- Ignore case while searching
vim.opt.smartcase = true          -- Smart case search (case-sensitive if uppercase is used)
vim.opt.showmatch = true          -- Highlight matching parentheses

-- ========================
-- File management settings
-- ========================
vim.opt.backup = false            -- Backup files
vim.opt.swapfile = false          -- Swap files
vim.opt.writebackup = false       -- Write backup files
vim.opt.undofile = false          -- Undo files

-- ====
-- Line
-- ====
vim.opt.cursorline = true        -- Highlight cursor line
vim.opt.number = true            -- Show absolute line numbers
vim.opt.relativenumber = true    -- Show relative line numbers

-- ==============
-- Other settings
-- ==============
vim.opt.belloff = "all"           -- Disable bell
vim.opt.updatetime = 300          -- Shorter update time for better responsiveness
vim.opt.mouse = "a"               -- Mouse support in all modes
vim.opt.showmode = true           -- Show current mode
