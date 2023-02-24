local open_with_trouble = function(...)
  require('trouble.providers.telescope').open_with_trouble(...)
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function(_, opts)
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    telescope.setup(opts)

    local keymaps = {
      { 'n', '<leader>,', builtin.buffers, 'buffers' },
      { 'n', '<leader>:', builtin.command_history, 'command history' },
      { 'n', '<leader>f*', builtin.grep_string, 'word under cursor' },
      {
        'n',
        '<leader>f/',
        function()
          builtin.current_buffer_fuzzy_find(
            require('telescope.themes').get_dropdown({ previewer = false })
          )
        end,
        'buffer',
      },
      { 'n', '<leader>fC', builtin.colorscheme, 'colorschemes' },
      { 'n', '<leader>fH', builtin.highlights, 'highlights' },
      { 'n', '<leader>fa', builtin.autocommands, 'autocommands' },
      { 'n', '<leader>fb', builtin.buffers, 'buffers' },
      { 'n', '<leader>fc', builtin.commands, 'commands' },
      { 'n', '<leader>ff', builtin.find_files, 'files' },
      { 'n', '<leader>fg', builtin.live_grep, 'find in files' },
      { 'n', '<leader>fh', builtin.help_tags, 'help tags' },
      { 'n', '<leader>fk', builtin.keymaps, 'keymaps' },
      { 'n', '<leader>fm', builtin.marks, 'marks' },
      { 'n', '<leader>fr', builtin.oldfiles, 'recent files' },
      { 'n', '<leader>gc', builtin.git_commits, 'commits' },
      { 'n', '<leader>gs', builtin.git_status, 'git status' },
    }

    for _, keymap in ipairs(keymaps) do
      local mode, l, r, desc = unpack(keymap)
      vim.keymap.set(mode, l, r, { desc = desc })
    end
  end,
  opts = {
    defaults = {
      mappings = {
        i = {
          ['<c-t>'] = open_with_trouble,
        },
        n = {
          ['<c-t>'] = open_with_trouble,
        },
      },
    },
  },
}
