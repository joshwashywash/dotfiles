return {
  'folke/trouble.nvim',
  cmd = { 'Trouble', 'TroubleToggle' },
  keys = {
    {
      '<leader>xx',
      function()
        require('trouble').toggle('document_diagnostics')
      end,
      desc = 'document diagnostics',
    },
    {
      '<leader>xx',
      function()
        require('trouble').toggle('workspace_diagnostics')
      end,
      desc = 'workspace diagnostics',
    },
    {
      ']x',
      function()
        require('trouble').next({ jump = true, skip_groups = true })
      end,
      desc = 'Next diagnostic',
    },
    {
      '[x',
      function()
        require('trouble').previous({ jump = true, skip_groups = true })
      end,
      desc = 'Prev diagnostic',
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
