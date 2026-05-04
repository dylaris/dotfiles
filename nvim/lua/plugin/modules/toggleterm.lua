return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction = "vertical",
    open_mapping = [[<c-\>]],
    size = function() return vim.o.columns / 2 end,
  },
}
