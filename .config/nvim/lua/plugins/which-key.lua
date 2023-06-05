return {
  'folke/which-key.nvim',
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts.popts)
    for _, set in ipairs(opts.mappings) do
      wk.register(unpack(set))
    end
  end,
  opts = {
    mappings = {
      {
        {
          ['['] = { name = '+prev' },
          [']'] = { name = '+next' },
          ['g'] = { name = '+goto' },
        },
        { mode = { 'n', 'v' } },
      },
      {
        {
          b = { name = 'buffer' },
          f = { name = 'find', l = 'lsp' },
          g = { name = 'git' },
          j = { name = 'join' },
          l = { name = 'lsp' },
          x = { name = 'diagnostics' },
        },
        { prefix = '<leader>' },
      },
    },
    popts = {
      window = { border = 'rounded' },
    },
  },
  event = 'VeryLazy',
}
