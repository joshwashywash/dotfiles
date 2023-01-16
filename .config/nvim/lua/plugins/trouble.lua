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
      '<leader>xX',
      function()
        require('trouble').toggle('workspace_diagnostics')
      end,
      desc = 'workspace diagnostics',
    },
    {
      ']n',
      function()
        require('trouble').next({ jump = true, skip_groups = true })
      end,
      desc = 'Next diagnostic',
    },
    {
      '[n',
      function()
        require('trouble').prev({ jump = true, skip_groups = true })
      end,
      desc = 'Prev diagnostic',
    },
  },
  opts = {
    {
      action_keys = {
        open_split = { 's' },
        open_vsplit = { 'v' },
      },
      height = 6,
    },
  },
}
