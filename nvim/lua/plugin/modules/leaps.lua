return {
  url = "https://codeberg.org/andyg/leap.nvim",
  config = function()
    vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap)', { desc = "Leap jump in current window" })
  end,
}
