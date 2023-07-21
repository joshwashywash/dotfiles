local dunno = '¯\\_(ツ)_/¯'
vim.api.nvim_create_user_command('Dunno', function()
	vim.api.nvim_put({ dunno }, '', { true }, { true })
end, { desc = string.format('put %s in the buffer', dunno) })
