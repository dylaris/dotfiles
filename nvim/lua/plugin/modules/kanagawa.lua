return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require('kanagawa').setup{
            commentStyle = { italic = false },
            keywordStyle = { italic = false},
            overrides = function(colors)
                return {
                    Normal = { bg = "#101010" },
                    CursorLine = { bg = "#000000" },
                    CursorLineNr = { bg = "#000000" },
                }
            end,
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            },
        }

        vim.cmd("colorscheme kanagawa-dragon")
    end
}
