local colorscheme = 'rose-pine'

return {
	'rose-pine/neovim',
	init = function()
		vim.cmd.colorscheme(colorscheme)
	end,
	lazy = false,
	name = colorscheme,
	opts = { dark_variant = 'moon' },
	priority = 1000,
}
