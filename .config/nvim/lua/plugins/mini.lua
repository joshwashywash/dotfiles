return {
	'echasnovski/mini.nvim',
	version = false,
	config = function()
		require('mini.ai').setup()
		require('mini.bracketed').setup()
		require('mini.bufremove').setup()
		require('mini.clue').setup()
		require('mini.comment').setup()
		require('mini.completion').setup()
		require('mini.cursorword').setup()
		require('mini.extra').setup()
		require('mini.files').setup({
			mappings = {
				close = '<esc>',
				go_in = '<s-right>',
				go_in_plus = '<right>',
				go_out = '<s-left>',
				go_out_plus = '<left>',
			},
		})
		require('mini.fuzzy').setup()
		require('mini.hipatterns').setup()
		require('mini.jump').setup()
		require('mini.move').setup({
			mappings = {
				down = '<m-down>',
				left = '<m-left>',
				right = '<m-right>',
				up = '<m-up>',

				line_down = '<m-down>',
				line_left = '<m-left>',
				line_right = '<m-right>',
				line_up = '<m-up>',
			},
		})
		require('mini.operators').setup()
		require('mini.pairs').setup()
		require('mini.pick').setup()
		require('mini.splitjoin').setup()
		require('mini.surround').setup()
		require('mini.visits').setup()
	end,
}
