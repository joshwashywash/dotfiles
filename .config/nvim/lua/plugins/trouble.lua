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
      ']x',
      vim.diagnostic.goto_next,
      desc = 'Next diagnostic',
    },
    {
      '[x',
      vim.diagnostic.goto_prev,
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
