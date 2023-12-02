return {
	'stevearc/oil.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	init = function()
		vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
	end,
	opts = {
		keymaps = {
			['<C-c>'] = false,
			['<C-s>'] = false,
			['<C-v>'] = 'actions.select_vsplit',
			['q'] = 'actions.close',
		},
	},
}
