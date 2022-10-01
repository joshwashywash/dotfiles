require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c',
    'cpp',
    'css',
    'dockerfile',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'php',
    'svelte',
    'typescript',
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_decremental = 'grm',
      node_incremental = 'grn',
      scope_incremental = 'grc',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']]'] = '@class.outer',
        [']m'] = '@function.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[['] = '@class.outer',
        ['[m'] = '@function.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['ac'] = '@class.outer',
        ['af'] = '@function.outer',
        ['ic'] = '@class.inner',
        ['if'] = '@function.inner',
      },
    },
  },
})
