return {
  "oskarnurm/koda.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("koda").setup{
      on_highlights = function(hl, c)
        hl.CursorLine = { bg = "NONE" }
        hl.CursorLineNr = { fg = "#5de4c7" }
        hl.LineNr = { fg = "#50585d" }
        hl.Search = { bg = "#A6ACCD", fg = "#000000" }
        hl.CurSearch = { bg = "#5de4c7", fg = "#000000" }
        hl.Type = { fg = "#5fb3a1" }
        hl.Cursor = { bg = "#fffac2" }
        hl.Visual = { bg = "#2E383C" }
      end,
      styles = {
        functions = { bold = false }
      },
      colors = {
        -- comment = "#757581",
        comment = "#9998a8",
        bg = "#0e1415",
        string = "#8fd8a3",
        char = "#fcc5e9",
        keyword = "#f2f6f9",
      },
    }

    vim.cmd("colorscheme koda-moss")
  end,
}
