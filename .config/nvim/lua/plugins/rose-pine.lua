local name = 'rose-pine'

return {
	'rose-pine/neovim',
	init = function()
		vim.cmd.colorscheme(name)
	end,
	lazy = false,
	name = name,
	opts = {
		dark_variant = 'moon',
	},
	priority = 1000,
}
