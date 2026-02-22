MiniDeps.later(function()
	MiniDeps.add('mfussenegger/nvim-lint')

	local lint = require('lint')

	vim.env.ESLINT_D_PPID = vim.fn.getpid()

	local eslint = {
		'eslint_d',
	}

	lint.linters_by_ft = {
		javascript = eslint,
		svelte = eslint,
		typescript = eslint,
	}

	vim.api.nvim_create_user_command('TryLint', function()
		lint.try_lint()
	end, {
		desc = 'try linting the buffer',
	})

	-- vim.api.nvim_create_autocmd({
	-- 	'BufEnter',
	-- 	'BufWritePost',
	-- }, {
	-- 	callback = function()
	-- 		lint.try_lint()
	-- 	end,
	-- 	desc = 'lint on write',
	-- 	group = vim.api.nvim_create_augroup('lint'),
	-- })
end)
