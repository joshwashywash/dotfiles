local prefix = '<leader>x'

return {
  'folke/trouble.nvim',
  cmd = { 'Trouble', 'TroubleToggle' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      prefix .. 'x',
      function()
        require('trouble').toggle('document_diagnostics')
      end,
      desc = 'document diagnostics',
    },
    {
      prefix .. 'X',
      function()
        require('trouble').toggle('workspace_diagnostics')
      end,
      desc = 'workspace diagnostics',
    },
  },
  opts = {
    action_keys = {
      open_split = { 's' },
      open_vsplit = { 'v' },
    },
    height = 6,
  },
}
