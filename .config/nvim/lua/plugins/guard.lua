return {
	'nvimdev/guard.nvim',
	config = function(_, opts)
		local ft = require('guard.filetype')

		for formatter, filetypes in pairs(opts.formatters) do
			ft(table.concat(filetypes, ',')):fmt(formatter)
		end

		require('guard').setup({
			fmt_on_save = true,
			lsp_as_default_formatter = false,
		})
	end,
	event = { 'BufNewFile', 'BufReadPre' },
	opts = {
		formatters = {
			prettierd = {
				'typescript',
				'javascript',
				'svelte',
				'css',
				'html',
				'json',
				'markdown',
				'markdown.mdx',
			},
			stylua = {
				'lua',
				'luau',
			},
		},
	},
}
