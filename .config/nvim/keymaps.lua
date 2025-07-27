--- @type {direction: string, lhs_suffix_key: string, rhs_suffix_key: string}[]
local window_focus_keymaps = {
	{
		direction = 'lower',
		lhs_suffix_key = '<down>',
		rhs_suffix_key = 'j',
	},
	{
		direction = 'left',
		lhs_suffix_key = '<left>',
		rhs_suffix_key = 'h',
	},
	{
		direction = 'right',
		lhs_suffix_key = '<right>',
		rhs_suffix_key = 'l',
	},
	{
		direction = 'upper',
		lhs_suffix_key = '<up>',
		rhs_suffix_key = 'k',
	},
}

for _, v in ipairs(window_focus_keymaps) do
	vim.keymap.set('n', '<c-w>' .. v.lhs_suffix_key, '<c-w>' .. v.rhs_suffix_key, {
		desc = 'focus ' .. v.direction .. ' window',
	})
end
