-- oil
require("oil").setup({
    -- set 'oil' as default file explorer when using like 'vim .'
    default_file_explorer = true,

    -- show hidden file
    view_options = {
        show_hidden = false,
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
      ["H"] = { "actions.toggle_hidden", mode = "n" },   -- switch to show hidden file
      ["C"] = { "actions.change_sort", mode = "n" },      -- change sort method
    },
})

-- treesitter
for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
  config.install_info.url = config.install_info.url:gsub("https://github.com/", "https://gh.llkk.cc/https://github.com/")
end
require("nvim-treesitter.configs").setup {
  ensure_installed = {
      "c", "lua", "cpp", "markdown", "make", "bash", "go",
      "javascript", "html", "css", "php", "python", "zig"
  },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {},
            disable = function(lang, buf)
                local max_filesize = 100 * 1024
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                return true
                end
            end,
        additional_vim_regex_highlighting = false,
    },
    -- Needed because treesitter highlight turns off autoindent for php files
    indent = {
        enable = true,
    },
}

-- kanagawa
require("kanagawa").setup{
    background = {
        dark = "wave",
        light = "lotus"
    },
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
    overrides = function(colors)
        return {
            LineNr = { bg = "none", fg = colors.theme.ui.nontext },
            CursorLineNr = { bg = "none", fg = colors.theme.ui.special, bold = true },
            CursorLine = { bg = "none" },
            SignColumn = { bg = "none" },
            FoldColumn = { bg = "none" },
            Comment = { bg = "none", fg = "#a4b8c4" },
            ["@variable.builtin"] = { italic = false },
            Pmenu = { fg = "#a9b1d6", bg = "#1f2335", blend = 10 },
            PmenuSel = { fg = "#000000", bg = "#83a598", bold = true, italic = false },
            PmenuSbar = { bg = "#292e42" },
            PmenuThumb = { bg = "#3d59a1" },
        }
    end,
}

-- ayu
local mirage = true
require('ayu').setup({
    mirage = mirage,
    overrides = function()
        local res = {
            Special = { fg = "#95E6CB" },
            Type = { fg = "#F07178" },
            ['@type'] = { fg = "#F07178" },
            ['@type.builtin'] = { fg = "#F07178" },
        }
        if not mirage then
            res['CursorLineNr'] = { bg = "none" }
            res['CursorLine'] = { bg = "None" }
        end
        return res
    end,
})

-- smooth cursor
require("smoothcursor").setup{
    fancy = { enable = true }
}

-- telescope
require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["jj"] = require('telescope.actions').close,
            },
        },
    },
})

-- mini.ai
local gen_spec = require('mini.ai').gen_spec
require("mini.ai").setup{
    custom_textobjects = {
        ['b'] = { { '%b()', '%b[]', '%b{}', '%b<>' }, '^.%s*().-()%s*.$' },
        ['B'] = { { '%b()', '%b[]', '%b{}', '%b<>' }, '^.().*().$' },
    }
}
