return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        { "nvim-mini/mini.icons", opts = {} },
    },
    config = function()
        require("lualine").hide()
        -- require("lualine").setup{
        --     options = {
        --         theme = 'auto',
        --     }
        -- }
    end,
}
