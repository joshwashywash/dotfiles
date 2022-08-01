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

--navigate buffers
local keymaps = {
  ['gT'] = function()
    bufferline.cycle(-1)
  end,
  ['gt'] = function()
    bufferline.cycle(1)
  end,
}

for k, v in pairs(keymaps) do
  vim.keymap.set('n', k, v)
end
