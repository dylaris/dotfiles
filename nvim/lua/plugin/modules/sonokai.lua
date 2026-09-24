return {
  'sainnhe/sonokai',
  lazy = false,
  priority = 1000,
  config = function()
    -- `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
    vim.g.sonokai_style = 'atlantis'
    vim.g.sonokai_transparent_background = 0
    vim.g.sonokai_enable_italic = false
    -- vim.cmd.colorscheme('sonokai')
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE' })
  end
}
