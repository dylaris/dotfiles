local is_windows = vim.fn.has('win32') == 1

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    shell = is_windows and "powershell" or "bash",
    direction = "vertical",
    open_mapping = [[<c-\>]],
    size = function() return vim.o.columns / 2 end,
  },
}
