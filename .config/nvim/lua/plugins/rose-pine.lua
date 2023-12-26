local colorscheme = 'rose-pine'

return {
	'rose-pine/neovim',
	config = true,
	init = function()
		vim.cmd.colorscheme(colorscheme)
	end,
	lazy = false,
	name = colorscheme,
	priority = 1000,
}
