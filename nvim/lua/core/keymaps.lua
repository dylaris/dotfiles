-- use space as leader key
vim.g.mapleader = " "

-- core
vim.keymap.set("i", "jk", "<esc>", {desc = "Exit insert mode"})
vim.keymap.set("c", "jk", "<cr>", {desc = "Run command"})
vim.keymap.set("c", "jj", "<C-c>", {desc = "Discard command"})
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", {desc = "Exit terminal mode"})
vim.keymap.set("n", "U", "<C-r>", {desc = "Reversed operation 'u'"})
vim.keymap.set("n", "<leader>s", ":w<cr>", {desc = "Save file"})
vim.keymap.set("n", "<leader>q", ":q<cr>", {desc = "Quit file"})
vim. keymap.set("n", "<leader>nh", ":nohl<cr>", {desc = "Clear search highlight"})
vim.keymap.set("v", "<tab>", ":normal @a<cr>", {desc = "Run macro 'a'"})

-- line operations
vim.keymap.set("n", "du", "d^", {desc = "Delete to line start"})
vim.keymap.set("n", "<enter>", function()
  if vim.bo.modifiable and not vim.bo.readonly then
    return "i<cr><esc>"
  else
    return "<cr>"
  end
end, {expr = true})

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
vim.keymap.set("n", "<leader>bn", "enew", {desc = "Create a new buffer"})
vim.keymap.set("n", "<leader>bo", close_other_buffers, {desc = "Close other buffers"})

-- window operations
vim.keymap.set("n", "<leader>wh", ":split<cr>", {desc = "Horizontal split window"})
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", {desc = "Vertical split window"})
vim.keymap.set("n", "<leader>wd", ":close<cr>", {desc = "Close window"})
vim.keymap.set("n", "<leader>wo", ":only<cr>", {desc = "Close other windows"})

-- tab operations
vim.keymap.set("n", "<leader>td", ":tabclose<cr>", {desc = "Close tab"})
vim.keymap.set("n", "<leader>to", ":tabonly<cr>", {desc = "Close other tabs"})
vim.keymap.set("n", "<leader>tn", ":tabnew<cr>", {desc = "Create a new tab"})

-- navigation
vim.keymap.set("n", "gi", function()
  local pos = vim.api.nvim_buf_get_mark(0, "^")
  if pos[1] == 0 then
    vim.notify("No previous insert position", vim.log.levels.ERROR)
    return
  end
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
vim.keymap.set({"n", "v"}, "<C-p>", "[[", {desc = "Go to previous function/class"})
vim.keymap.set({"n", "v"}, "<C-n>", "]]", {desc = "Go to next function/class"})
vim.keymap.set({"n", "v"}, "<C-k>", "{", {desc = "Go to previous paragraph"})
vim.keymap.set({"n", "v"}, "<C-j>", "}", {desc = "Go to next paragraph"})
vim.keymap.set({"n", "v"}, "<space><space>", "%", {desc = "Go to matching bracket"})
vim.keymap.set("n", "<A-h>", "<C-w>wh", {desc = "Go to left window"})
vim.keymap.set("n", "<A-l>", "<C-w>wl", {desc = "Go to right window"})
vim.keymap.set("n", "<A-k>", "<C-w>wk", {desc = "Go to up window"})
vim.keymap.set("n", "<A-j>", "<C-w>wj", {desc = "Go to down window"})
vim.keymap.set("n", "<A-n>", ":tabnext<cr>", {desc = "Go to next tab"})
vim.keymap.set("n", "<A-p>", ":tabprevious<cr>", {desc = "Go to previous tab"})

