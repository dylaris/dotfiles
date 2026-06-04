return {
  'nvim-mini/mini.move',
  version = '*',
  config = function()
    require("mini.move").setup{}
    -- disable move in normal mode (empty string is not work :-<)
    vim.keymap.set('n', '<M-h>', '<Nop>')
    vim.keymap.set('n', '<M-j>', '<Nop>')
    vim.keymap.set('n', '<M-k>', '<Nop>')
    vim.keymap.set('n', '<M-l>', '<Nop>')
  end
}
