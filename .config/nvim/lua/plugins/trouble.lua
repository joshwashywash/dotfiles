local prefix = '<leader>d'

return {
  'folke/trouble.nvim',
  cmd = { 'Trouble', 'TroubleToggle' },
  keys = {
    {
      prefix .. 'd',
      function()
        require('trouble').toggle('document_diagnostics')
      end,
      desc = 'document diagnostics',
    },
    {
      prefix .. 'D',
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
