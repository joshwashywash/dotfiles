require('lualine').setup({
  options = {
    component_separators = { left = '', right = '' },
    globalstatus = true,
  },
  inactive_sections = {},
  sections = {},
  tabline = {
    lualine_a = { 'tabs' },
    lualine_b = {
      {
        'buffers',
        filetype_names = { NvimTree = 'NvimTree' },
        symbols = { alternate_file = '' },
      },
    },
    lualine_c = { 'diagnostics' },
    lualine_x = {},
    lualine_y = {
      'diff',
      'branch',
    },
    lualine_z = { 'mode' },
  },
})
