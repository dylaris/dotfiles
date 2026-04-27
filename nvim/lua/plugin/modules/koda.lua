return {
    "oskarnurm/koda.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("koda").setup{
            on_highlights = function(hl, c)
                hl.LineNr = { fg = "#707070" }
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

        -- vim.cmd("colorscheme koda")
        -- vim.cmd("highlight CursorLine guibg=none")
        -- vim.cmd("highlight CursorLineNr guibg=none")
    end,
}
