return {
  'TimUntersberger/neogit',
  config = function(_, opts)
    local palette = require('rose-pine.palette')

    local groups = {
      NeogitNotificationError = { fg = palette.love },
      NeogitNotificationInfo = { fg = palette.foam },
      NeogitNotificationWarning = { fg = palette.gold },
    }

    for group, hl in pairs(groups) do
      vim.api.nvim_set_hl(0, group, hl)
    end

    local neogit = require('neogit')
    neogit.setup(opts)
  end,
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    {
      '<leader>gP',
      function()
        require('neogit').open()
      end,
      desc = 'open neogit',
    },
  },
  opts = { kind = 'split' },
}
