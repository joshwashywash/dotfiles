MiniDeps.later(function()
	local bufremove = require('mini.bufremove')

	bufremove.setup()

	local prefix = '<leader>b'

	vim.keymap.set('n', prefix .. 'd', bufremove.delete, { desc = 'delete' })
	vim.keymap.set('n', prefix .. 'u', bufremove.unshow, { desc = 'unshow' })
	vim.keymap.set('n', prefix .. 'w', bufremove.wipeout, { desc = 'wipeout' })
end)
