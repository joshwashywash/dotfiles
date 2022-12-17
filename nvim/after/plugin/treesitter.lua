require('nvim-treesitter.configs').setup({
  autotag = { enable = true },
  ensure_installed = {
    'astro',
    'css',
    'dart',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'svelte',
    'typescript',
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_decremental = '<c-bs>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
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
        ['aa'] = '@parameter.outer',
        ['ac'] = '@class.outer',
        ['af'] = '@function.outer',
        ['ia'] = '@parameter.inner',
        ['ic'] = '@class.inner',
        ['if'] = '@function.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>sn'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>sp'] = '@parameter.inner',
      },
    },
  },
})
