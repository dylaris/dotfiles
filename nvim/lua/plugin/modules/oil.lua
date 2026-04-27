return {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = {
        { "nvim-mini/mini.icons", opts = {} },
    },
    config = function()
        require("oil").setup({
            -- set 'oil' as default file explorer when using like 'vim .'
            default_file_explorer = true,

            -- show hidden file
            view_options = {
                show_hidden = true,
            },

            -- add border
            float = { border = "rounded" },
            confirmation = { border = "rounded" },
            progress = { border = "rounded" },
            ssh = { border = "rounded" },
            keymaps_help = { border = "rounded" },

            -- display column info
            columns = {
                "icon",
                "permissions",
                "size",
                "mtime",
            },

            -- internal key map
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["<C-p>"] = "actions.preview",                -- preview file content
                ["J"] = { "actions.select", mode = "n" },     -- open file or enter directory
                ["K"] = { "actions.parent", mode = "n" },     -- go back to parent directory
                ["W"] = { "actions.open_cwd", mode = "n" },   -- open the current working directory
                ["R"] = { "actions.refresh", mode = "n" },    -- Refresh oil buffer
                ["S"] = { "actions.cd", mode = "n" },         -- set current directory as working directory
                -- ["H"] = { "actions.toggle_hidden", mode = "n" },   -- switch to show hidden file
                ["C"] = { "actions.change_sort", mode = "n" },      -- change sort method
            },
        })

        vim.keymap.set("n", "<leader>e", ":Oil --float<cr>")
    end,
}
