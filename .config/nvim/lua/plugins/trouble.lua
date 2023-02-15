return {
  'folke/trouble.nvim',
  cmd = { 'Trouble', 'TroubleToggle' },
  keys = {
    {
      '<leader>dd',
      function()
        require('trouble').toggle('document_diagnostics')
      end,
      desc = 'document diagnostics',
    },
    {
      '<leader>dD',
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
