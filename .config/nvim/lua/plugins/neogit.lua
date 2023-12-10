return {
	'NeogitOrg/neogit',
	config = true,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope.nvim',
		'sindrets/diffview.nvim',
		'ibhagwan/fzf-lua',
	},
	keys = {
		{
			'<leader>gP',
			function()
				require('neogit').open({ kind = 'split' })
			end,
			desc = 'open neogit',
		},
	},
}
