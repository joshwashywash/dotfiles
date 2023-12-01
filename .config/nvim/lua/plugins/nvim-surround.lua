return {
	'kylechui/nvim-surround',
	event = 'VeryLazy',
	opts = {
		keymaps = {
			insert = '<C-g>u',
			insert_line = '<C-g>U',
			normal = 'yu',
			normal_cur = 'yuu',
			normal_line = 'yU',
			normal_cur_line = 'yUU',
			visual = 'U',
			visual_line = 'gU',
			delete = 'du',
			change = 'cu',
			change_line = 'cU',
		},
	},
}
