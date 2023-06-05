local prefix = '<leader>f'

return {
  'nvim-telescope/telescope.nvim',
  config = function()
    local t = require('telescope')
    local builtin = require('telescope.builtin')

    local fb_actions = require('telescope').extensions.file_browser.actions

    t.setup({
      defaults = {
        layout_config = { horizontal = { preview_width = 0.6 } },

        prompt_prefix = '  ',
        selection_caret = '  ',
      },
      extensions = {
        file_browser = {
          display_stat = false,
          hijack_netrw = true,
          mappings = {
            i = {
              ['<c-b>'] = fb_actions.goto_parent_dir,
              ['<c-e>'] = false,
              ['<c-f>'] = fb_actions.toggle_browser,
              ['<c-h>'] = fb_actions.goto_home_dir,
              ['<c-i>'] = fb_actions.toggle_hidden,
              ['<c-j>'] = fb_actions.change_cwd,
              ['<c-t>'] = false,
            },
            n = {
              b = fb_actions.goto_parent_dir,
              e = false,
              f = fb_actions.toggle_browser,
              h = fb_actions.goto_home_dir,
              i = fb_actions.toggle_hidden,
              j = fb_actions.change_cwd,
              t = false,
            },
          },
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
      { 'G', builtin.git_commits, 'git commits' },
      { 'H', builtin.highlights, 'highlights' },
      { 'L', builtin.resume, 'resume last search' },
      { 'a', builtin.autocommands, 'autocommands' },
      {
        'b',
        function()
          require('telescope').extensions.file_browser.file_browser({
            grouped = true,
          })
        end,
        'file browser',
      },
      { 'c', builtin.colorscheme, 'colorschemes' },
      { 'F', builtin.find_files, 'files' },
      {
        'f',
        function()
          require('telescope').extensions.file_browser.file_browser({
            grouped = true,
            path = '%:p:h',
            select_buffer = true,
          })
        end,
        'file browser at current buffer',
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
      { 'u', builtin.buffers, 'buffers' },
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
