return {
  'folke/which-key.nvim',
  config = function()
    local wk = require('which-key')
    wk.setup()
    
    wk.register({
      ['['] = { name = '+prev' },
      [']'] = { name = '+next' },
      ['g'] = { name = '+goto' },
    }, { mode = { 'n', 'v' } })

    wk.register({
      b = { name = 'buffer' },
      e = { name = 'explorer' },
      f = { name = 'find' },
      g = { name = 'git' },
      l = { name = 'lsp' },
      x = { name = 'diagnostics' },
    }, { prefix = '<leader>' })
  end,
  event = 'VeryLazy',
}
