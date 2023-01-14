return {
  'rose-pine/neovim',
  config = function()
    require('rose-pine').setup({
      dark_variant = 'moon',
      highlight_groups = {
        EndOfBuffer = { fg = 'base', bg = 'base' },
      },
    })
    vim.cmd.colorscheme('rose-pine')
  end,
  lazy = false,
  name = 'rose-pine',
  priority = 1000,
}
