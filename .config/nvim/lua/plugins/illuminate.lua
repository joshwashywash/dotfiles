return {
	'RRethy/vim-illuminate',
	config = function(_, opts)
		local groups = {
			'IlluminatedWordRead',
			'IlluminatedWordText',
			'IlluminatedWordWrite',
		}

		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { strikethrough = true })
		end

		require('illuminate').configure(opts)
	end,
	event = 'BufReadPost',
	keys = {
		{
			']]',
			function()
				require('illuminate').goto_next_reference(false)
			end,
			desc = 'next reference',
		},
		{
			'[[',
			function()
				require('illuminate').goto_prev_reference(false)
			end,
			desc = 'prev reference',
		},
	},
	opts = { delay = 500 },
}
