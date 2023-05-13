return {
  'rose-pine/neovim',
  config = function()
    require('rose-pine').setup({
      dark_variant = 'moon',
      highlight_groups = {
        FloatBorder = { bg = 'none', fg = 'highlight_high' },
        LazyButton = { link = 'Normal' },
        LazyNormal = { link = 'Normal' },
        LspInfoBorder = { link = 'FloatBorder' },
        LspReferenceRead = { bg = 'base' },
        LspSignatureActiveParameter = { link = 'Selection' },
        MasonHeader = { bg = 'highlight_low', fg = 'gold' },
        MasonMutedBlock = { link = 'Normal' },
        MasonNormal = { link = 'Normal' },
        NormalFloat = { link = 'Normal' },
        NvimTreeNormal = { fg = 'subtle' },
        NvimTreeCursorLine = { link = 'Selection' },
        Selection = { fg = 'highlight_low', bg = 'gold' },
        TelescopePromptNormal = { bg = 'none' },
        TelescopeNormal = { fg = 'subtle', bg = 'none' },
        TelescopeBorder = { link = 'FloatBorder' },
        TelescopeNormalPmenuSel = { link = 'Selection' },
        TelescopeSelection = { link = 'Selection' },
        WhichKeyFloat = { link = 'Normal' },
      },
    })
    vim.cmd.colorscheme('rose-pine')
  end,
  lazy = false,
  name = 'rose-pine',
  priority = 1000,
}
