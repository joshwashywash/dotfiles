local rose_pine_name = 'rose-pine'

return {
	'rose-pine/neovim',
	config = function(_, opts)
		require(rose_pine_name).setup(opts)
		vim.cmd.colorscheme(rose_pine_name)
	end,
	opts = {
		dark_variant = 'moon',
	},
	lazy = false,
	name = rose_pine_name,
	priority = 1000,
}
