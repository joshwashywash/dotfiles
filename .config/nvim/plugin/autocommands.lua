vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.hl.on_yank()
	end,
	desc = 'highlight on yank',
	group = vim.api.nvim_create_augroup('highlight-on-yank', {}),
})
