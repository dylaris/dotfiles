return {
  "oskarnurm/koda.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("koda").setup{
      on_highlights = function(hl, c)
        hl.CursorLine = { bg = "#000000" }
        hl.CursorLineNr = { bg = "#000000" }
      end,
      styles = {
        functions = { bold = false }
      },
      colors = {
        -- comment = "#c98f6a",
        -- bg = "#0e1415",
        string = "#8FD8A3",
        char = "#8FD8A3",
      },
    }

    -- vim.cmd("colorscheme koda-moss")
  end,
}
