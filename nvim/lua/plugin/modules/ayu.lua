return {
  'ayu-theme/ayu-vim',
  config = function()
    vim.g.ayucolor = "mirage"
    vim.cmd.colorscheme('ayu')
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'NONE', fg = '#ffcc66' })
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#1f2430' })
  end
}
