local prefix = '<leader>f'

return {
  'nvim-telescope/telescope.nvim',
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    local trouble = require('trouble.providers.telescope')

    telescope.setup({
      defaults = {
        layout_config = { horizontal = { preview_width = 0.6 } },
        mappings = {
          i = {
            ['<c-t>'] = trouble.open_with_trouble,
          },
          n = {
            ['<c-t>'] = trouble.open_with_trouble,
          },
        },
        prompt_prefix = '  ',
        selection_caret = '  ',
      },
      extensions = {
        file_browser = {
          display_stat = false,
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    })

    local extensions = {
      'fzf',
      'file_browser',
    }

    local t = require('telescope')

    for _, extension in ipairs(extensions) do
      t.load_extension(extension)
    end

    local normal_mode_keymaps = {
      {
        '/',
        function()
          builtin.current_buffer_fuzzy_find(
            require('telescope.themes').get_dropdown({ previewer = false })
          )
        end,
        'in current buffer',
      },
      { '*', builtin.grep_string, 'word under cursor' },
      { ':', builtin.command_history, 'command history' },
      { 'C', builtin.commands, 'commands' },
      { 'f', builtin.find_files, 'files' },
      { 'G', builtin.git_commits, 'git commits' },
      { 'H', builtin.highlights, 'highlights' },
      { 'L', builtin.resume, 'resume last search' },
      { 'a', builtin.autocommands, 'autocommands' },
      { 'b', builtin.buffers, 'buffers' },
      { 'c', builtin.colorscheme, 'colorschemes' },
      {
        'f',
        function()
          require('telescope').extensions.file_browser.file_browser({
            grouped = true,
          })
        end,
        'file browser',
      },
      { 'g', builtin.live_grep, 'live grep' },
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
      {
        'u',
        function()
          require('telescope').extensions.file_browser.file_browser({
            grouped = true,
            path = '%:p:h',
            select_buffer = true,
          })
        end,
        'file browser at current buffer',
      },
    }

    for _, keymap in ipairs(normal_mode_keymaps) do
      local l, r, desc = unpack(keymap)
      vim.keymap.set('n', prefix .. l, r, { desc = desc, noremap = true })
    end
  end,
  cmd = {
    'Telescope',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    prefix,
  },
}
