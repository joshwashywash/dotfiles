local prefix = '<leader>f';

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
      { 'n', ':', builtin.command_history, 'command history' },
      { 'n', '*', builtin.grep_string, 'word under cursor' },
      {
        'n',
        '/',
        function()
          builtin.current_buffer_fuzzy_find(
            require('telescope.themes').get_dropdown({ previewer = false })
          )
        end,
        'in current buffer',
      },
      { 'n', 'C', builtin.colorscheme, 'colorschemes' },
      { 'n', 'G', builtin.git_commits, 'git commits' },
      { 'n', 'H', builtin.highlights, 'highlights' },
      { 'n', 'L', builtin.resume, 'resume last search' },
      { 'n', 'a', builtin.autocommands, 'autocommands' },
      { 'n', 'b', builtin.buffers, 'buffers' },
      { 'n', 'c', builtin.commands, 'commands' },
      { 'n', 'f', builtin.find_files, 'files' },
      { 'n', 'g', builtin.live_grep, 'find in files' },
      { 'n', 'h', builtin.help_tags, 'help tags' },
      { 'n', 'k', builtin.keymaps, 'keymaps' },
      { 'n', 'm', builtin.marks, 'marks' },
      { 'n', 'r', builtin.oldfiles, 'recent files' },
      { 'n', 's', builtin.git_status, 'git status' },
    }

    for _, keymap in ipairs(keymaps) do
      local mode, l, r, desc = unpack(keymap)
      vim.keymap.set(mode, prefix .. l, r, { desc = desc })
    end
  end,
  cmd = {
    'Telescope'
  },
  keys = {
    prefix,
  },
}