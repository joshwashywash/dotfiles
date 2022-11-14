local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<c-t>'] = trouble.open_with_trouble,
      },
      n = {
        ['<c-t>'] = trouble.open_with_trouble,
        j = actions.move_selection_previous,
        k = actions.move_selection_next,
      },
    },
  },
})
