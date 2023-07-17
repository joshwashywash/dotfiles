return {
	'famiu/bufdelete.nvim',
	keys = {
		{
			'<leader>bq',
			function()
				require('bufdelete').bufdelete(0)
			end,
			desc = 'quit',
		},
		{
			'<leader>bQ',
			function()
				require('bufdelete').bufdelete(0, true)
			end,
			desc = 'force quit',
		},
		{
			'<leader>bw',
			function()
				require('bufdelete').bufwipeout(0)
			end,
			desc = 'wipeout',
		},
		{
			'<leader>bW',
			function()
				require('bufdelete').bufwipeout(0, true)
			end,
			desc = 'force wipeout',
		},
	},
}
