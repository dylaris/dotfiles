return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('telescope').setup{
            defaults = {
                mappings = {
                    i = {
                        ["jj"] = require('telescope.actions').close,
                    },
                },
            },
        }
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ft', builtin.current_buffer_fuzzy_find, { desc = 'Telescope text' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>ff', builtin.find_files , { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fa', function()
            builtin.find_files({ hidden = true })
        end, { desc = 'Telescope find files (including hidden)' })
    end,
}
