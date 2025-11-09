MiniDeps.later(function()
	local diff = require('mini.diff')

	diff.setup({
		view = {
			priority = vim.diagnostic.config().signs.priority - 1,
		},
	})

	vim.keymap.set('n', '<leader>go', diff.toggle_overlay, {
		desc = 'toggle diff overlay',
	})
end)
