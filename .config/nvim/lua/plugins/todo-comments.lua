-- load when entering a buffer not on keys
return {
	'folke/todo-comments.nvim',
	config = function()
		local todo = require('todo-comments')
		todo.setup()
		local keymaps = {
			{
				']t',
				function()
					todo.jump_next()
				end,
				'next todo comment',
			},
			{
				'[t',
				function()
					todo.jump_prev()
				end,
				'previous todo comment',
			},
		}

		for _, keymap in ipairs(keymaps) do
			local l, r, desc = unpack(keymap)
			vim.keymap.set('n', l, r, {
				desc = desc,
				noremap = true,
				silent = true,
			})
		end
	end,
	dependencies = { 'nvim-lua/plenary.nvim' },
	event = 'BufEnter',
}
