-- Set indent for language
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    local indent_configs = {
      lua = 2,
      wren = 2,
      html = 2,
      css = 2,
      javascript = 2,
      typescript = 2,
      vim = 2,
    }
    local width = indent_configs[vim.bo.filetype] or 4
    vim.opt_local.tabstop = width
    vim.opt_local.shiftwidth = width
    vim.opt_local.softtabstop = width
  end
})

-- Set compiler for language
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"c3", "python"},
  callback = function(args)
    local ft = args.match
    local compilers = {
      c3 = "c3c",
      python = "pyunit",
    }
    vim.cmd("compiler " .. compilers[ft])
  end
})

-- Set errorfmt for language
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"javascript", "typescript"},
  callback = function(args)
    local ft = args.match
    local patterns = {
      javascript = [[%\\s%\\+at\ %f:%l:%c,%f:%l]],
      typescript = [[%\\s%\\+at\ %f:%l:%c,%f:%l]],
    }
    vim.bo.errorformat = patterns[ft] or ""
  end
})

-- Set filetype=c for C header file
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.h",
  command = "set filetype=c"
})

-- Set filetype=fasm for asm/inc file
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.asm", "*.inc"},
  command = "set filetype=fasm"
})

-- Automatically remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.cmd([[%s/\r//e]])
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end
})

-- Disable auto comment
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({"c", "r", "o", "O"})
  end,
})
