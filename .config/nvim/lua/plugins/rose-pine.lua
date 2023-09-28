local rose_pine_name = 'rose-pine'

return {
	'rose-pine/neovim',
	config = function(_, opts)
		require(rose_pine_name).setup(opts)
		vim.cmd.colorscheme(rose_pine_name)
	end,
	opts = {
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
			NeogitNotificationError = { fg = 'love' },
			NeogitNotificationInfo = { fg = 'foam' },
			NeogitNotificationWarning = { fg = 'gold' },
			NormalFloat = { link = 'Normal' },
			Selection = { fg = 'highlight_low', bg = 'gold' },
			TelescopeBorder = { link = 'FloatBorder' },
			TelescopeNormal = { fg = 'subtle', bg = 'none' },
			TelescopeNormalPmenuSel = { link = 'Selection' },
			TelescopePromptNormal = { bg = 'none' },
			TelescopeSelection = { link = 'Selection' },
			WhichKeyFloat = { link = 'Normal' },
		},
	},
	lazy = false,
	name = rose_pine_name,
	priority = 1000,
}
