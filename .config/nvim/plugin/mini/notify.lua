MiniDeps.now(function()
	require('mini.notify').setup({
		window = {
			config = function()
				local has_statusline = vim.o.laststatus > 0
				local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
				return {
					anchor = 'SE',
					col = vim.o.columns,
					row = vim.o.lines - pad,
				}
			end,
		},
	})
end)
