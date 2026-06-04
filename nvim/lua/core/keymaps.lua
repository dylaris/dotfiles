-- use space as leader key
vim.g.mapleader = " "

-- core
vim.keymap.set("i", "jk", "<esc>", {desc = "Exit insert mode"})
vim.keymap.set("c", "jk", "<cr>", {desc = "Run command"})
vim.keymap.set("c", "jj", "<C-c>", {desc = "Discard command"})
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", {desc = "Exit terminal"})
vim.keymap.set("n", "U", "<C-r>", {desc = "Redo"})
vim.keymap.set("n", "<leader>s", ":w<cr>", {desc = "Save"})
vim.keymap.set("n", "<leader>q", ":q<cr>", {desc = "Quit"})
vim.keymap.set("n", "<leader>nh", ":nohl<cr>", {desc = "Clear highlights"})
vim.keymap.set("v", "<tab>", ":normal @a<cr>", {desc = "Run macro 'a'"})

-- line operations
vim.keymap.set("n", "dh", "d^", {desc = "Delete to line start"})
vim.keymap.set("n", "dl", "d$", {desc = "Delete to line end"})
vim.keymap.set("n", "yh", "y^", {desc = "Yank to line start"})
vim.keymap.set("n", "yl", "y$", {desc = "Yank to line end"})
vim.keymap.set("n", "ch", "c^", {desc = "Change to line start"})
vim.keymap.set("n", "cl", "c$", {desc = "Change to line end"})
vim.keymap.set("n", "<enter>", function()
  if vim.bo.modifiable and not vim.bo.readonly then
    return "i<cr><esc>"
  else
    return "<cr>"
  end
end, {expr = true, desc = "Insert new line above"})
-- vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv", {desc = "Move lines down"})
-- vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv", {desc = "Move lines up"})
vim.keymap.set("n", "gp", "`[v`]", {desc = "Select text just pasted"})

-- quickfix
vim.keymap.set("n", "<leader>co", ":copen<cr>", {desc = "Open quickfix"})
vim.keymap.set("n", "<leader>cc", ":cclose<cr>", {desc = "Close quickfix"})
vim.keymap.set("n", "<leader>cn", ":cnext<cr>", {desc = "Next item"})
vim.keymap.set("n", "<leader>cp", ":cprev<cr>", {desc = "Prev item"})
vim.keymap.set("n", "<leader>cf", ":cfirst<cr>", {desc = "First item"})
vim.keymap.set("n", "<leader>cl", ":clast<cr>", {desc = "Last item"})

-- buffer operations
vim.keymap.set("n", "<leader>bd", ":bd<cr>", {desc = "Close buffer"})
vim.keymap.set("n", "<leader>bD", ":bd!<cr>", {desc = "Close buffer (force)"})
vim.keymap.set("n", "<leader>bv", ":b#<cr>", {desc = "Alternate buffer"})
vim.keymap.set("n", "<leader>bp", ":redir @+ | echo expand('%:p') | redir end<cr>", {desc = "Copy path"})
vim.keymap.set("n", "<leader>bt", function() open_buffer_in_win("down", true) end, {desc = "Temp buffer"})
vim.keymap.set("n", "<leader>be", function() open_buffer_in_win("down") end, {desc = "New buffer"})
vim.keymap.set("n", "<leader>bo", close_other_buffers, {desc = "Close others"})

-- window operations
vim.keymap.set("n", "<leader>wh", ":split<cr>", {desc = "Split horizontal"})
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", {desc = "Split vertical"})
vim.keymap.set("n", "<leader>wd", ":close<cr>", {desc = "Close window"})
vim.keymap.set("n", "<leader>wo", ":only<cr>", {desc = "Only this window"})

-- term operations
vim.keymap.set("n", "<leader>tt", open_term_in_tab, {desc = "Terminal in new tab"})
vim.keymap.set("n", "<leader>tv", function() open_term_in_win('right') end, {desc = "Terminal right"})
vim.keymap.set("n", "<leader>th", function() open_term_in_win('down') end, {desc = "Terminal down"})
vim.keymap.set('n', '<leader>to', only_terminal, {desc = "Only this terminal"})
vim.keymap.set('n', '<leader>td', close_terminal, {desc = "Close terminal"})
vim.keymap.set('n', '<leader>tx', close_all_terminals, {desc = "Close all terminals"})

-- navigation
vim.keymap.set("n", "g.", "'.", {desc = "Last edit"})
vim.keymap.set("v", "<enter>", "<cmd>JumpToError<cr>", {desc = "Open error"})
vim.keymap.set("n", "gh", "^", {desc = "Line start"})
vim.keymap.set("v", "gh", "^", {desc = "Line start"})
vim.keymap.set("n", "gl", "$", {desc = "Line end"})
vim.keymap.set("v", "gl", "$h", {desc = "Line end"})
vim.keymap.set({"n", "v"}, "gm", "%", {desc = "Match bracket"})
vim.keymap.set({"n", "v"}, "<C-k>", "5k", {desc = "Move up 5 lines "})
vim.keymap.set({"n", "v"}, "<C-j>", "5j", {desc = "Move down 5 lines"})
vim.keymap.set("n", "<A-h>", "<C-w>h", {desc = "Left window"})
vim.keymap.set("n", "<A-l>", "<C-w>l", {desc = "Right window"})
vim.keymap.set("n", "<A-k>", "<C-w>k", {desc = "Up window"})
vim.keymap.set("n", "<A-j>", "<C-w>j", {desc = "Down window"})
vim.keymap.set("n", "<A-n>", ":tabnext<cr>", {desc = "Next tab"})
vim.keymap.set("n", "<A-p>", ":tabprev<cr>", {desc = "Previous tab"})
