MiniDeps.later(function()
	local clue = require('mini.clue')

	local clues = {
		clue.gen_clues.builtin_completion(),
		clue.gen_clues.g(),
		clue.gen_clues.marks(),
		clue.gen_clues.registers(),
		clue.gen_clues.windows({
			submode_resize = true,
		}),
		clue.gen_clues.z(),
		{ mode = 'n', keys = '<leader>b', desc = 'buffer' },
		{ mode = 'n', keys = '<leader>d', desc = 'deps' },
		{ mode = 'n', keys = '<leader>e', desc = 'explore' },
		{ mode = 'n', keys = '<leader>f', desc = 'find' },
		{ mode = 'n', keys = '<leader>g', desc = 'git' },
		{ mode = 'n', keys = '[b', postkeys = '[' },
		{ mode = 'n', keys = '[w', postkeys = '[' },
		{ mode = 'n', keys = ']b', postkeys = ']' },
		{ mode = 'n', keys = ']w', postkeys = ']' },
	}

	local triggers = {
		{ mode = 'n', keys = ']' },
		{ mode = 'n', keys = '[' },

		-- Leader triggers
		{ mode = 'n', keys = '<leader>' },
		{ mode = 'x', keys = '<leader>' },

		-- Built-in completion
		{ mode = 'i', keys = '<c-x>' },

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
		{ mode = 'i', keys = '<c-r>' },
		{ mode = 'c', keys = '<c-r>' },

		-- Window commands
		{ mode = 'n', keys = '<c-w>' },

		-- `z` key
		{ mode = 'n', keys = 'z' },
		{ mode = 'x', keys = 'z' },
	}

	local window = {
		config = {
			anchor = 'SW',
			col = 'auto',
			row = 'auto',
		},
	}

	clue.setup({
		clues = clues,
		triggers = triggers,
		window = window,
	})
end)
