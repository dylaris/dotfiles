local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Colorscheme
    { "rebelot/kanagawa.nvim" },
    { "Shatur/neovim-ayu" },

    -- Fuzzy search
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim', },
    },

    -- Exacyly jump
    { "ggandor/leap.nvim", },

    -- Edit file like buffer
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        lazy = false,
    },

    -- Quickly comment
    {
        'echasnovski/mini.comment',
        config = function()
            require('mini.comment').setup()
        end
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master', lazy = false, build = ":TSUpdate"
    },

    -- Alignment
    {
        'nvim-mini/mini.align',
        version = '*',
        config = function()
            require('mini.align').setup({
                mappings = {
                  start = '',
                },
            })
        end
    },

    -- Smooth cursor
    { 'gen740/SmoothCursor.nvim' },
    { "sphamba/smear-cursor.nvim", opts = { smear_insert_mode = false } },

    -- Output shell command to quickfix
    { "skywind3000/asyncrun.vim" },

    -- Textobj
    { 'nvim-mini/mini.ai', version = '*', },

    -- Surround
    {
        'nvim-mini/mini.surround',
        version = '*',
        config = function()
            require('mini.surround').setup()
        end
    },
}, {
    git = {
        url_format = "https://gh.bugdey.us.kg/https://github.com/%s.git"
    }
})
