return {
	'folke/flash.nvim',
	event = 'VeryLazy',
	---@type Flash.Config
	opts = {},
	keys = {
		{
			'S',
			mode = { 'n', 'x', 'o' },
			function()
				require('flash').jump({
					search = {
						mode = function(str)
							return '\\<' .. str
						end,
					},
				})
			end,
			desc = 'Flash',
		},
		{
			's',
			mode = { 'n', 'o', 'x' },
			function()
				require('flash').treesitter()
			end,
			desc = 'Flash Treesitter',
		},
		{
			'X',
			mode = 'o',
			function()
				require('flash').remote()
			end,
			desc = 'Remote Flash',
		},
		{
			'x',
			mode = { 'o', 'x' },
			function()
				require('flash').treesitter_search()
			end,
			desc = 'Flash Treesitter Search',
		},
		{
			'<c-s>',
			mode = { 'c' },
			function()
				require('flash').toggle()
			end,
			desc = 'Toggle Flash Search',
		},
	},
}
