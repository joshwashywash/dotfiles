return {
	'folke/which-key.nvim',
	opts = {
		window = { border = 'rounded' },
	},
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	event = 'VeryLazy',
}
