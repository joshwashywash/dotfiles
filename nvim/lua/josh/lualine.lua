require('lualine').setup({
  options = {
    component_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = {},
    lualine_x = { 'diagnostics' },
    lualine_y = { { 'buffers', symbols = { alternate_file = '' } } },
    lualine_z = { 'tabs' },
  },
})
