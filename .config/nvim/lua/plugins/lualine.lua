return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  opts = {
    extensions = { 'nvim-tree' },
    options = {
      component_separators = { left = '', right = '' },
      globalstatus = true,
    },
    sections = {
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
  },
}
