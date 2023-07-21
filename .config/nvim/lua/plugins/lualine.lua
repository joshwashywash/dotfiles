return {
	'nvim-lualine/lualine.nvim',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	event = 'ColorScheme',
	opts = {
		extensions = { 'nvim-tree' },
		options = {
			component_separators = {
				left = '',
				right = '',
			},
			section_separators = {
				left = '',
				right = '',
			},
			globalstatus = true,
			theme = 'rose-pine',
		},
		sections = {
			lualine_a = {
				'tabs',
			},
			lualine_b = {
				{
					'buffers',
					symbols = { alternate_file = '' },
				},
			},
			lualine_c = {
				'diagnostics',
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {
				'diff',
				'branch',
			},
		},
	},
}
