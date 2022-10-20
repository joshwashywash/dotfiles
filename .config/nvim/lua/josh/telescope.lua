local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<c-h>'] = actions.move_selection_previous,
        ['<c-k>'] = actions.move_selection_next,
        ['<c-t>'] = trouble.open_with_trouble,
      },
      n = {
        ['<c-t>'] = trouble.open_with_trouble,
        h = actions.move_selection_previous,
        k = actions.move_selection_next,
      },
    },
  },
})
