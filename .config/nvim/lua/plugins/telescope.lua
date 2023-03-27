local prefix = '<leader>f'

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
            ['<c-t>'] = trouble.open_with_trouble,
          },
          n = {
            ['<c-t>'] = trouble.open_with_trouble,
          },
        },
      },
    })

    local normal_mode_keymaps = {
      { '*', builtin.grep_string, 'word under cursor' },
      {
        '/',
        function()
          builtin.current_buffer_fuzzy_find(
            require('telescope.themes').get_dropdown({ previewer = false })
          )
        end,
        'in current buffer',
      },
      { ':', builtin.command_history, 'command history' },
      { 'C', builtin.commands, 'commands' },
      { 'G', builtin.git_commits, 'git commits' },
      { 'H', builtin.highlights, 'highlights' },
      { 'L', builtin.resume, 'resume last search' },
      { 'a', builtin.autocommands, 'autocommands' },
      { 'b', builtin.buffers, 'buffers' },
      { 'c', builtin.colorscheme, 'colorschemes' },
      { 'f', builtin.find_files, 'files' },
      { 'g', builtin.live_grep, 'find in files' },
      { 'h', builtin.help_tags, 'help tags' },
      { 'k', builtin.keymaps, 'keymaps' },
      { 'ld', builtin.lsp_definitions, 'definitions' },
      { 'li', builtin.lsp_implementations, 'implementations' },
      { 'lr', builtin.lsp_references, 'references' },
      { 'ls', builtin.lsp_document_symbols, 'document symbols' },
      { 'lt', builtin.lsp_type_definitions, 'type definitions' },
      { 'lw', builtin.lsp_workspace_symbols, 'workspace symbols' },
      { 'lx', builtin.diagnostics, 'diagnostics' },
      { 'm', builtin.marks, 'marks' },
      { 'r', builtin.oldfiles, 'recent files' },
      { 's', builtin.git_status, 'git status' },
    }

    for _, keymap in ipairs(normal_mode_keymaps) do
      local l, r, desc = unpack(keymap)
      vim.keymap.set('n', prefix .. l, r, { desc = desc })
    end
  end,
  cmd = {
    'Telescope',
  },
  keys = {
    prefix,
  },
}
