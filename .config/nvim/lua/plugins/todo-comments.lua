-- load when entering a buffer not on keys
return {
	'folke/todo-comments.nvim',
	cmd = { 'TodoTrouble', 'TodoTelescope' },
	config = true,
	dependencies = { 'nvim-lua/plenary.nvim' },
	event = { 'BufNewFile', 'BufReadPost' },
	keys = {
		{
			']t',
			function()
				require('todo-comments').jump_next()
			end,
			desc = 'next todo comment',
		},
		{
			'[t',
			function()
				require('todo-comments').jump_prev()
			end,
			desc = 'prev todo comment',
		},
	},
}
