local actions = require('telescope.actions')
local telescope = require('telescope')
local trouble = require('trouble.providers.telescope')
local builtin = require('telescope.builtin')
local wk = require('which-key')

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<c-t>'] = trouble.open_with_trouble, -- move results into trouble window
      },
      n = {
        ['<c-t>'] = trouble.open_with_trouble,
      },
    },
  },
})

wk.register({
  f = {
    name = 'find',
    ['/'] = {
      function()
        builtin.current_buffer_fuzzy_find(
          require('telescope.themes').get_dropdown({
            previewer = false,
            winblend = 10,
          })
        )
      end,
      'find word in current buffer',
    },
    B = { builtin.git_branches, 'git branches' },
    C = { builtin.git_bcommits, 'git buffer commits with diff preview' },
    D = { builtin.diagnostics, 'diagnostics for all open buffers' },
    R = {
      builtin.lsp_references,
      'references for the word under the cursor',
    },
    S = {
      builtin.git_status,
      'current changes per file with diff preview',
    },
    T = { builtin.treesitter, 'function names, variables, etc.' },
    b = { builtin.buffers, 'buffers' },
    c = { builtin.git_commits, 'commits with diff preview' },
    d = {
      builtin.lsp_definitions,
      'definitions for the word under the cursor',
    },
    f = { builtin.find_files, 'list files' },
    g = {
      builtin.live_grep,
      'search for a word in the current working directory',
    },
    h = { builtin.help_tags, 'available help tags' },
    r = { builtin.oldfiles, 'recent files' },
    s = { builtin.git_stash, 'git stash' },
    t = {
      builtin.lsp_type_definitions,
      'type definitions of word under the cursor',
    },
    w = { builtin.grep_string, 'search for the word under the cursor' },
  },
}, { prefix = '<leader>' })
