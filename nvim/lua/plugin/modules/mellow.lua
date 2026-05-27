return {
  'mellow-theme/mellow.nvim',
  config = function()
    vim.g.mellow_italic_comments = false
    vim.g.mellow_highlight_overrides = {
      ["Function"] = { fg = "#f5a191" },
      ["@variable.member"] = { fg = "#85b5ba" }
    }
    -- vim.cmd("colorscheme mellow")
  end
}
