return {
  'rose-pine/neovim',
  config = function()
    require('rose-pine').setup({
      dark_variant = 'moon',
      highlight_groups = {
        EndOfBuffer = { fg = 'base', bg = 'base' },
        FloatBorder = { bg = 'none', fg = 'highlight_high' },
        LazyButton = { link = 'Normal' },
        LazyNormal = { link = 'Normal' },
        LspInfoBorder = { fg = 'highlight_high' },
        LspReferenceRead = { bg = 'base' },
        LspSignatureActiveParameter = { link = 'Selection' },
        MasonHeader = { bg = 'base', fg = 'gold' },
        MasonMutedBlock = { link = 'Normal' },
        MasonNormal = { link = 'Normal' },
        NormalFloat = { link = 'Normal' },
        NvimTreeCursorLine = { link = 'Selection' },
        Selection = { fg = 'gold', bg = 'base' },
        TelescopeBorder = { bg = 'none', fg = 'highlight_high' },
        TelescopeNormal = { link = 'Normal' },
        TelescopeNormalPmenuSel = { bg = 'base', fg = 'gold' },
        TelescopePromptNormal = { link = 'Normal' },
        TelescopeResultsNormal = { bg = 'none', fg = 'subtle' },
        TelescopeSelection = { link = 'Selection' },
        TelescopeSelectionCaret = { bg = 'base', fg = 'base' },
        WhichKeyFloat = { link = 'Normal' },
      },
    })
    vim.cmd.colorscheme('rose-pine')
  end,
  lazy = false,
  name = 'rose-pine',
  priority = 1000,
}
