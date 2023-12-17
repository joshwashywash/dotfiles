return {
	'echasnovski/mini.nvim',
	version = false,
	config = function()
		require('mini.ai').setup()
		require('mini.bracketed').setup()
		require('mini.bufremove').setup()
		local clue = require('mini.clue')
		clue.setup({
			clues = {
				{ mode = 'n', keys = '<leader>b', desc = 'buffer' },
				{ mode = 'n', keys = '<leader>p', desc = 'pick' },
				-- Enhance this by adding descriptions for <Leader> mapping groups
				clue.gen_clues.builtin_completion(),
				clue.gen_clues.g(),
				clue.gen_clues.marks(),
				clue.gen_clues.registers(),
				clue.gen_clues.windows(),
				clue.gen_clues.z(),
			},
			triggers = {

				-- Leader triggers
				{ mode = 'n', keys = '<Leader>' },
				{ mode = 'x', keys = '<Leader>' },

				-- Built-in completion
				{ mode = 'i', keys = '<C-x>' },

				-- `g` key
				{ mode = 'n', keys = 'g' },
				{ mode = 'x', keys = 'g' },

				-- Marks
				{ mode = 'n', keys = "'" },
				{ mode = 'n', keys = '`' },
				{ mode = 'x', keys = "'" },
				{ mode = 'x', keys = '`' },

				-- Registers
				{ mode = 'n', keys = '"' },
				{ mode = 'x', keys = '"' },
				{ mode = 'i', keys = '<C-r>' },
				{ mode = 'c', keys = '<C-r>' },

				-- Window commands
				{ mode = 'n', keys = '<C-w>' },

				-- `z` key
				{ mode = 'n', keys = 'z' },
				{ mode = 'x', keys = 'z' },
			},
		})
		require('mini.comment').setup()
		require('mini.completion').setup()
		require('mini.cursorword').setup()
		local extra = require('mini.extra')
		extra.setup()
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
		local hi_words = extra.gen_highlighter.words
		local hipatterns = require('mini.hipatterns')
		hipatterns.setup({
			highlighters = {
				fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
				hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
				todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
				note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})

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
