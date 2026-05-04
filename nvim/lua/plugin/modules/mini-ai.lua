return {
  'nvim-mini/mini.ai',
  version = '*',
  config = function()
    require("mini.ai").setup{
      custom_textobjects = {
        ['b'] = { { '%b()', '%b[]', '%b{}', '%b<>' }, '^.%s*().-()%s*.$' },
        ['B'] = { { '%b()', '%b[]', '%b{}', '%b<>' }, '^.().*().$' },
      }
    }
  end,
}
