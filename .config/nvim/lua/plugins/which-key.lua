return {
	'folke/which-key.nvim',
	config = function(_, opts)
		local wk = require('which-key')
		wk.setup(opts.popts)
		for _, set in ipairs(opts.mappings) do
			wk.register(unpack(set))
		end
	end,
	event = 'VeryLazy',
	opts = {
		mappings = {
			{
				{
					['['] = { name = 'prev' },
					[']'] = { name = 'next' },
					['g'] = { name = 'goto' },
				},
				{ mode = { 'n', 'v' } },
			},
			{
				{
					b = { name = 'buffer' },
					f = { name = 'find', l = { name = 'lsp' } },
					g = { name = 'git' },
					j = { name = 'join' },
					-- TODO: lsp's name doesn't show up on the which key menu
					l = { name = 'lsp' },
					x = { name = 'diagnostics' },
				},
				{ prefix = '<leader>' },
			},
		},
		popts = {
			window = { border = 'rounded' },
		},
	},
}
