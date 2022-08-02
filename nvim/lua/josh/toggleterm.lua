require('toggleterm').setup({
  direction = 'float',
  open_mapping = [[<c-\>]],
  float_opts = { border = 'curved' },
})

local keymaps = {
  -- go into normal mode
  ['<esc>'] = '<c-\\><c-n>',
  ['<c-[>'] = '<c-\\><c-n>',

  -- navigate windows while leaving terminal open
  ['<c-h>'] = '<c-\\><c-n><c-w>k',
  ['<c-j>'] = '<c-\\><c-n><c-w>h',
  ['<c-k>'] = '<c-\\><c-n><c-w>j',
  ['<c-l>'] = '<c-\\><c-n><c-w>l',
}

local group = vim.api.nvim_create_augroup('TermKeyBinds', { clear = true })

vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    for k, v in pairs(keymaps) do
      vim.keymap.set('t', k, v)
    end
  end,
  group = group,
})
