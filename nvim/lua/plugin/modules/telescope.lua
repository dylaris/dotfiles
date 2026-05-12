return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('telescope').setup{
      defaults = {
        layout_config = {
          horizontal = {
            prompt_position = "top",
          }
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["jj"] = require('telescope.actions').close,
          },
        },
       file_ignore_patterns = {
          ".*[\\/]%.git[\\/].*",
          ".*%.o",
          ".*%.obj",
        },
      },
    }
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ft', builtin.current_buffer_fuzzy_find, { desc = 'Telescope text' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>ff', function()
      local is_windows = vim.fn.has('win32') == 1
      local paths = { vim.fn.getcwd() }
      if is_windows then
        table.insert(paths, "C:\\Users\\Aris\\AppData\\Local\\nvim")
        table.insert(paths, "D:\\Project\\Personal\\cheatshit")
      else
        table.insert(paths, vim.fn.expand("~/.config/nvim"))
        table.insert(paths, vim.fn.expand("~/project/cheatshit"))
      end
      builtin.find_files({
        search_dirs = paths,
        follow = true,
        hidden = true,
      })
    end, { desc = 'Telescope find files' })
  end,
}
