return {
  'folke/which-key.nvim',
  config = function()
    local wk = require('which-key')
    wk.setup({ window = { border = 'rounded' } })

    wk.register({
      ['['] = { name = '+prev' },
      [']'] = { name = '+next' },
      ['g'] = { name = '+goto' },
    }, { mode = { 'n', 'v' } })

    wk.register({
      b = { name = 'buffer' },
      f = { name = 'find', l = 'lsp' },
      g = { name = 'git' },
      j = { name = 'join' },
      l = { name = 'lsp' },
      x = { name = 'diagnostics' },
    }, { prefix = '<leader>' })
  end,
  event = 'VeryLazy',
}
