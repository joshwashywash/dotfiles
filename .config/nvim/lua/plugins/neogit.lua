return {
	'NeogitOrg/neogit',
	dependencies = 'nvim-lua/plenary.nvim',
	keys = {
		{
			'<leader>gP',
			function()
				require('neogit').open()
			end,
			desc = 'open neogit',
		},
	},
	opts = {
		kind = 'split',
	},
}
