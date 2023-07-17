return {
	'Wansmer/treesj',
	opts = { use_default_keymaps = false },
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	keys = {
		{
			'<leader>jj',
			function()
				require('treesj').join()
			end,
			desc = 'join',
		},
		{
			'<leader>js',
			function()
				require('treesj').split()
			end,
			desc = 'split',
		},
		{
			'<leader>jt',
			function()
				require('treesj').toggle()
			end,
			desc = 'toggle',
		},
	},
}
