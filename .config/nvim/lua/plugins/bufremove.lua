return {
	'echasnovski/mini.bufremove',
	keys = {
		{
			'<leader>bq',
			function()
				require('mini.bufremove').delete(0, false)
			end,
			desc = 'quit',
		},
		{
			'<leader>bQ',
			function()
				require('mini.bufremove').delete(0, true)
			end,
			desc = 'quit buffer with force',
		},
	},
}
