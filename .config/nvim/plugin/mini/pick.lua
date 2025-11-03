MiniDeps.later(function()
	local pick = require('mini.pick')

	pick.setup({
		mappings = {
			refine = '<c-n>',
			refine_marked = '<c-p>',
		},
		window = {
			config = function()
				local height = math.floor(0.7 * vim.o.lines)
				local width = math.floor(0.7 * vim.o.columns)
				return {
					anchor = 'NW',
					height = height,
					width = width,
					row = math.floor(0.5 * (vim.o.lines - height)),
					col = math.floor(0.5 * (vim.o.columns - width)),
				}
			end,
		},
	})

	local pickers = require('mini.extra').pickers

	--- @type {mode: string|string[], lhs_suffix_key: string, rhs: string|function, opts: vim.keymap.set.Opts}[]
	local picks = {
		{
			mode = 'n',
			lhs_suffix_key = 'B',
			rhs = pickers.buf_lines,
			opts = {
				desc = 'lines in buffer',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'F',
			rhs = pick.builtin.files,
			opts = {
				desc = 'files',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'H',
			rhs = pickers.hl_groups,
			opts = {
				desc = 'highlight groups',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'R',
			rhs = pickers.registers,
			opts = {
				desc = 'registers',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'b',
			rhs = pick.builtin.buffers,
			opts = {
				desc = 'buffers',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'c',
			rhs = pickers.commands,
			opts = {
				desc = 'commands',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'd',
			rhs = pickers.diagnostic,
			opts = {
				desc = 'diagnostic',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'e',
			rhs = pickers.explorer,
			opts = {
				desc = 'explorer',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'f',
			rhs = function()
				pickers.oldfiles({
					current_dir = true,
				})
			end,
			opts = {
				desc = 'recent files',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'g',
			rhs = pick.builtin.grep_live,
			opts = {
				desc = 'live grep',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'h',
			rhs = pick.builtin.help,
			opts = {
				desc = 'help',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'k',
			rhs = pickers.keymaps,
			opts = {
				desc = 'keymaps',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'm',
			rhs = pickers.marks,
			opts = {
				desc = 'marks',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'o',
			rhs = pickers.options,
			opts = {
				desc = 'options',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'p',
			rhs = pickers.hipatterns,
			opts = {
				desc = 'highlight patterns',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'r',
			rhs = pick.builtin.resume,
			opts = {
				desc = 'resume',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 's',
			rhs = pickers.history,
			opts = {
				desc = 'history',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 't',
			rhs = pickers.treesitter,
			opts = {
				desc = 'treesitter',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'u',
			rhs = pickers.spellsuggest,
			opts = {
				desc = 'spellsuggest',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'v',
			rhs = pickers.visit_paths,
			opts = {
				desc = 'visits',
			},
		},
	}

	for _, p in ipairs(picks) do
		vim.keymap.set(p.mode, '<leader>f' .. p.lhs_suffix_key, p.rhs, p.opts)
	end
end)
