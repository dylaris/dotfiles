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
        "javascript", "html", "css", "php", "python",
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

-- nvim-cmp
local cmp = require("cmp")
cmp.setup({
    sources = {
        {
            name = "buffer",
            option = {
                get_bufnrs = function ()
                    return vim.api.nvim_list_bufs()
                end
            }
        },
        { name = "tags" },
        { name = "path" },
    },
})
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    },
    mapping = cmp.mapping.preset.cmdline({
        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.close() end
            fallback()
        end, { "c" }),
        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.close() end
            fallback()
        end, { "c" }),
    }),
})
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "cmdline" },
        { name = "path" },
    }),
    mapping = cmp.mapping.preset.cmdline({
        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.close() end
            fallback()
        end, { "c" }),
        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.close() end
            fallback()
        end, { "c" }),
    }),
})

-- lualine
require("lualine").setup{
    options = {
        theme = 'auto',
    }
}

-- asyncrun
local os = vim.loop.os_uname().sysname
if os == "Windows_NT" then
    vim.g.asyncrun_encs = 'gbk'
end
