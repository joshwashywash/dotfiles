local wk = require('which-key')

local trouble = require('trouble')

trouble.setup({
  action_keys = {
    open_split = { 's' },
    open_vsplit = { 'v' },
  },
  height = 6,
})

wk.register({
  t = {
    name = 'trouble',
    D = {
      function()
        trouble.toggle('document_diagnostics')
      end,
      'document diagnostics',
    },
    d = {
      function()
        trouble.toggle('lsp_definitions')
      end,
      'definitions',
    },
    l = {
      function()
        trouble.toggle('loclist')
      end,
      'loclist',
    },
    n = {
      function()
        trouble.next({ skip_group = true, jump = true })
      end,
      'next ',
    },
    p = {
      function()
        trouble.previous({ skip_group = true, jump = true })
      end,
      'previous',
    },
    q = {
      function()
        trouble.toggle('quickfix')
      end,
      'quickfix',
    },
    r = {
      function()
        trouble.toggle('lsp_references')
      end,
      'references',
    },
    t = { trouble.toggle, 'toggle' },
    w = {
      function()
        trouble.toggle('workspace_diagnostics')
      end,
      'workspace diagnostics',
    },
    y = {
      function()
        trouble.toggle('lsp_type_definitions')
      end,
      'type definitions',
    },
  },
}, { prefix = '<leader>' })
