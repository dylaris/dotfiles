return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "quangnguyen30192/cmp-nvim-tags",
    },
    config = function()
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
            matching = {
                disallow_fuzzy_matching = false,
                disallow_partial_matching = false,
                disallow_prefix_unmatching = false,
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
            }),
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline({
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
            }),
            sources = { { name = 'buffer' } }
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline({
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
            }),
            sources = cmp.config.sources({
                { name = "cmdline" },
                { name = "path" },
            })
        })
    end,
}
