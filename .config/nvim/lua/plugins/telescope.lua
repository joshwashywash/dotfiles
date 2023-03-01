return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    local trouble = require('trouble.providers.telescope')

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<c-t>'] = trouble.open_with_trouble
          },
          n = {
            ['<c-t>'] = trouble.open_with_trouble
          },
        },
      },
    })

    local keymaps = {
      { 'n', '<leader>f:', builtin.command_history, 'command history' },
      { 'n', '<leader>f*', builtin.grep_string, 'word under cursor' },
      {
        'n',
        '<leader>f/',
        function()
          builtin.current_buffer_fuzzy_find(
            require('telescope.themes').get_dropdown({ previewer = false })
          )
        end,
        'in current buffer',
      },
      { 'n', '<leader>fC', builtin.colorscheme, 'colorschemes' },
      { 'n', '<leader>fG', builtin.git_commits, 'git commits' },
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
      { 'n', '<leader>fs', builtin.git_status, 'git status' },
    }

    for _, keymap in ipairs(keymaps) do
      local mode, l, r, desc = unpack(keymap)
      vim.keymap.set(mode, l, r, { desc = desc })
    end
  end,
  cmd = {
    'Telescope'
  },
  keys = {
    '<leader>f'
  },
}