local bufdelete = require('bufdelete')
local gitsigns = require('gitsigns.actions')
local neogit = require('neogit')
local nvimtree = require('nvim-tree')
local packer = require('packer')
local telescope = require('telescope.builtin')
local trouble = require('trouble')
local wk = require('which-key')

wk.register({
  b = {
    name = 'buffer actions',
    d = {
      function()
        bufdelete.bufdelete(0)
      end,
      'delete',
    },
    D = {
      function()
        vim.cmd('%bdelete')
      end,
      'delete all buffers',
    },
    w = {
      function()
        bufdelete.bufwipeout(0)
      end,
      'wipeout',
    },
    W = {
      function()
        vim.cmd('%bwipeout')
      end,
      'wipeout all buffers',
    },
    n = {
      vim.cmd.bnext,
      'next',
    },
    N = {
      vim.cmd.bprevious,
      'previous',
    },
  },
  e = {
    name = 'explorer',
    f = {
      function()
        nvimtree.find_file(true)
      end,
      'find file',
    },
    t = { nvimtree.toggle, 'toggle' },
  },
  f = {
    name = 'find',
    ['/'] = {
      function()
        telescope.current_buffer_fuzzy_find(
          require('telescope.themes').get_dropdown({
            previewer = false,
            winblend = 10,
          })
        )
      end,
      'find word in current buffer',
    },
    D = { telescope.diagnostics, 'list diagnostics for all open buffers' },
    R = {
      telescope.lsp_references,
      'list references for the word under the cursor',
    },
    T = { telescope.treesitter, 'list function names, variables, etc.' },
    b = { telescope.buffers, 'list open buffers' },
    d = {
      telescope.lsp_definitions,
      'definitions for the word under the cursor',
    },
    f = { telescope.find_files, 'list files' },
    g = {
      telescope.live_grep,
      'search for a word in the current working directory',
    },
    h = { telescope.help_tags, 'list available help tags' },
    r = { telescope.oldfiles, 'list recent files' },
    t = {
      telescope.lsp_type_definitions,
      'list type definitions of word under the cursor',
    },
    w = { telescope.grep_string, 'search for the word under the cursor' },
  },
  g = {
    name = 'git',
    B = { telescope.git_branches, 'list branches' },
    C = { telescope.git_bcommits, 'list buffer commits with diff preview' },
    D = { gitsigns.diffthis, 'diff' },
    H = { gitsigns.undo_stage_hunk, 'undo stage hunk' },
    N = { gitsigns.prev_hunk, 'previous hunk' },
    P = { neogit.open, 'neogit' },
    R = { gitsigns.reset_buffer, 'reset buffer' },
    S = {
      telescope.git_status,
      'list current changes per file with diff preview',
    },
    b = { gitsigns.blame_line, 'blame' },
    c = { telescope.git_commits, 'list all commits with diff preview' },
    d = { gitsigns.toggle_deleted, 'toggle deleted' },
    h = { gitsigns.stage_hunk, 'stage hunk' },
    n = { gitsigns.next_hunk, 'next hunk' },
    p = { gitsigns.preview_hunk, 'preview hunk' },
    r = { gitsigns.reset_hunk, 'reset hunk' },
    s = { gitsigns.stage_buffer, 'stage buffer' },
    t = { telescope.git_stash, 'list stash items' },
  },
  p = {
    name = 'packer',
    S = { packer.status, 'status' },
    s = { packer.sync, 'sync' },
  },
  t = {
    name = 'trouble',
    D = {
      function()
        trouble.toggle('document_diagnostics')
      end,
      'document diagnostics',
    },
    d = {
      function()
        trouble.toggle('lsp_definitions')
      end,
      'definitions',
    },
    l = {
      function()
        trouble.toggle('loclist')
      end,
      'loclist',
    },
    n = {
      function()
        trouble.next({ skip_group = true, jump = true })
      end,
      'next ',
    },
    p = {
      function()
        trouble.previous({ skip_group = true, jump = true })
      end,
      'previous',
    },
    q = {
      function()
        trouble.toggle('quickfix')
      end,
      'quickfix',
    },
    r = {
      function()
        trouble.toggle('lsp_references')
      end,
      'references',
    },
    t = { trouble.toggle, 'toggle' },
    w = {
      function()
        trouble.toggle('workspace_diagnostics')
      end,
      'workspace diagnostics',
    },
    y = {
      function()
        trouble.toggle('lsp_type_definitions')
      end,
      'type definitions',
    },
  },
}, { prefix = '<leader>' })
