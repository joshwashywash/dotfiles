return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      autotag = { enable = true },
      ensure_installed = {
        'astro',
        'css',
        'dart',
        'help',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'svelte',
        'typescript',
        'vim',
      },
      highlight = {
        enable = true, -- false will disable the whole extension
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-j>',
          node_decremental = '<c-m>',
          node_incremental = '<c-j>',
          scope_incremental = '<c-s>',
        },
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']c'] = '@class.outer',
            [']m'] = '@function.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']C'] = '@class.outer',
          },
          goto_previous_start = {
            ['[c'] = '@class.outer',
            ['[m'] = '@function.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[C'] = '@class.outer',
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
          -- <c-n> and <c-p> are aliases for up and down in normal mode
          swap_next = {
            ['<c-n>'] = '@parameter.inner',
          },
          swap_previous = {
            ['<c-p>'] = '@parameter.inner',
          },
        },
      },
    })
  end,
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  event = 'BufReadPost',
}
