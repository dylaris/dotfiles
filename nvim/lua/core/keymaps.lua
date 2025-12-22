-- use space as leader key
vim.g.mapleader = " "

-- core
vim.keymap.set("i", "jk", "<esc>", {desc = "Exit insert mode"})
vim.keymap.set("c", "jk", "<cr>", {desc = "Run command"})
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", {desc = "Exit terminal mode"})
vim.keymap.set("n", "U", "<C-r>", {desc = "Reversed operation 'u'"})
vim.keymap.set("n", "<leader>r", ":!", {desc = "Run external command"})
vim.keymap.set("n", "<leader>s", ":w<cr>", {desc = "Save file"})
vim.keymap.set("n", "<leader>q", ":q<cr>", {desc = "Quit file"})
vim.keymap.set("n", "<leader>nh", ":nohl<cr>", {desc = "Clear search highlight"})
vim.keymap.set("v", "<tab>", ":normal @a<cr>", {desc = "Run macro 'a'"})

-- line operations
vim.keymap.set("n", "du", "d^", {desc = "Delete to line start"})

-- quickfix
vim.keymap.set("n", "<leader>co", ":copen<cr>", {desc = "Open quickfix window"})
vim.keymap.set("n", "<leader>cc", ":cclose<cr>", {desc = "Close quickfix window"})
vim.keymap.set("n", "<leader>cn", ":cnext<cr>", {desc = "Jump to next fix"})
vim.keymap.set("n", "<leader>cp", ":cprev<cr>", {desc = "Jump to previous fix"})
vim.keymap.set("n", "<leader>cf", ":cfirst<cr>", {desc = "Jump to first fix"})
vim.keymap.set("n", "<leader>cl", ":clast<cr>", {desc = "Jump to last fix"})

-- buffer operations
vim.keymap.set("n", "<leader>bd", ":bd<cr>", {desc = "Close buffer"})
vim.keymap.set("n", "<leader>bu", ":bun<cr>", {desc = "Unload buffer"})
vim.keymap.set("n", "<leader>bv", ":b#<cr>", {desc = "Switch to last visited buffer"})
vim.keymap.set("n", "<leader>bp", ":redir @+ | echo expand('%:p') | redir end<cr>", {desc = "Show buffer path"})
vim.keymap.set("n", "<leader>bt", create_temp_buffer, {desc = "Create temp buffer"})
vim.keymap.set("n", "<leader>bo", close_other_buffers, {desc = "Close other buffers"})

-- window operations
vim.keymap.set("n", "<leader>wh", ":split<cr>", {desc = "Horizontal split window"})
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", {desc = "Vertical split window"})
vim.keymap.set("n", "<leader>wc", ":close<cr>", {desc = "Close window"})
vim.keymap.set("n", "<leader>wo", ":only<cr>", {desc = "Close other windows"})
vim.keymap.set("n", "<leader>ww", "<C-w>w", {desc = "Switch window"})

-- navigation
vim.keymap.set("n", "gi", function()
    vim.cmd('normal! m`')
    vim.cmd('normal! `^')
end, { desc = 'Go to last insert (with jump history)' })
vim.keymap.set("n", "gj", "<C-]>", {desc = "Go to definition (tag)"})
vim.keymap.set("n", "gb", "<C-t>", {desc = "Go back from tag (tag stack)"})
vim.keymap.set("v", "<enter>", "<cmd>JumpToError<cr>", {desc = "Open error position in split window"})
vim.keymap.set("n", "<C-h>", "^", {desc = "Go to line start"})
vim.keymap.set("v", "<C-h>", "^", {desc = "Go to line start"})
vim.keymap.set("n", "<C-l>", "$", {desc = "Go to line end"})
vim.keymap.set("v", "<C-l>", "$h", {desc = "Go to line end (no newline)"})
vim.keymap.set({"n", "v"}, "<C-p>", "[m", {desc = "Go to previous method"})
vim.keymap.set({"n", "v"}, "<C-n>", "]m", {desc = "Go to next method"})
vim.keymap.set({"n", "v"}, "<C-k>", "{", {desc = "Go to previous paragraph"})
vim.keymap.set({"n", "v"}, "<C-j>", "}", {desc = "Go to next paragraph"})
vim.keymap.set({"n", "v"}, "<C-m>", "%", {desc = "Go to matching bracket"})

-- ====== native useful command ======
-- gg: Go to first line of file
-- G: Go to last line of file (Shift+g)

-- m{register}: Mark at current position (:marks to see all marks)
-- 'register}: Go to mark line
-- `{register}: Go to exact mark position
-- g;: Go to older change in changelist
-- g,: Go to newer change in changelist
-- gi: Go to last insertion point and enter insert mode

-- gd: Go to local definition (current file)
-- gD: Go to global definition (across files)
-- gf: Open file under cursor
-- gF: Open file:line under cursor

-- gu: Make lowercase (operator, e.g., guw for word)
-- gU: Make uppercase (operator, e.g., gUw for word)
-- g~: Toggle case (operator, e.g., g~w for word)
-- guu: Make current line lowercase
-- gUU: Make current line uppercase
-- g~~: Toggle case of current line

-- gv: Reselect last visual selection

-- ga: Show ASCII/Unicode value of character under cursor
-- g8: Show UTF-8 byte sequence of character under cursor
-- gCtrl+g: Show detailed file/position information
-- g<: Show older command-line history
-- g>: Show newer command-line history

-- gx: Open URL under cursor with default application

-- gt: Go to next tab
-- gT: Go to previous tab
