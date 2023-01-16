return {
  'folke/which-key.nvim',
  config = function()
    local wk = require('which-key')
    wk.setup()
    local mode = { 'n', 'v' }
    wk.register({
      ['['] = { name = '+prev' },
      [']'] = { name = '+next' },
      ['g'] = { name = '+goto' },
      mode = mode,
    })

    wk.register({
      b = { name = 'buffer' },
      e = { name = 'explorer' },
      f = { name = 'find' },
      g = { name = 'git' },
      x = { name = 'diagnostics' },
    }, { prefix = '<leader>' })
  end,
  event = 'VeryLazy',
}
