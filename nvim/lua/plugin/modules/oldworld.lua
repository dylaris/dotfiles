return {
  "dgox16/oldworld.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("oldworld").setup{
      variant = "cooler", -- default, oled, cooler
      highlight_overrides = {
        CursorLine = { bg = "#000000" },
        CursorLineNr = { bg = "#000000" }
      }
    }
    vim.cmd("colorscheme oldworld")
  end
}
