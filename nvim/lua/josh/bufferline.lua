local bufferline = require('bufferline')

bufferline.setup({
  options = {
    offsets = {
      {
        filetype = 'NvimTree',
        highlight = 'Directory',
        text = 'explorer',
        text_align = 'center',
      },
    },
    middle_mouse_command = function(bufnr)
      require('bufdelete').bufdelete(bufnr)
    end,
    show_close_icon = false,
  },
})

-- cycle buffers
local t = { ['gT'] = -1, ['gt'] = 1 }

for k, v in pairs(t) do
  vim.keymap.set('n', k, function()
    bufferline.cycle(v)
  end)
end
