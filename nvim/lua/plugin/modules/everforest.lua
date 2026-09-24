return {
  'sainnhe/everforest',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.everforest_transparent_background = 2
    vim.g.everforest_enable_italic = false
    -- vim.cmd.colorscheme('everforest')
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE' })
  end
}
