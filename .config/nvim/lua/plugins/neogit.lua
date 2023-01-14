return {
  'TimUntersberger/neogit',
  config = function()
    local palette = require('rose-pine.palette')

    local groups = {
      NeogitNotificationError = { fg = palette.love },
      NeogitNotificationInfo = { fg = palette.foam },
      NeogitNotificationWarning = { fg = palette.gold },
    }

    for group, hl in pairs(groups) do
      vim.api.nvim_set_hl(0, group, hl)
    end

    require('neogit').setup({ kind = 'split' })
  end,
  dependencies = 'nvim-lua/plenary.nvim',
}
