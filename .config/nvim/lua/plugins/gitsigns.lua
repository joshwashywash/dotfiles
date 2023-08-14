return {
	'lewis6991/gitsigns.nvim',
	event = { 'BufNewFile', 'BufReadPre' },
	opts = {
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns
			local keymaps = {
				{
					{ 'o', 'x' },
					'ih',
					':<c-u>Gitsigns select_hunk<CR>',
					'select hunk',
				},
				{
					'n',
					'<leader>gD',
					function()
						gs.diffthis('~')
					end,
					'diff this ~',
				},
				{
					'n',
					'<leader>gR',
					gs.reset_buffer,
					'reset buffer',
				},
				{
					'n',
					'<leader>gS',
					gs.stage_buffer,
					'stage buffer',
				},
				{
					'n',
					'<leader>gb',
					function()
						gs.blame_line({ full = true })
					end,
					'blame line',
				},
				{
					'n',
					'<leader>gd',
					function()
						gs.diffthis('', { split = 'belowright' })
					end,
					'diff this',
				},
				{ 'n', '<leader>gp', gs.preview_hunk, 'preview hunk' },
				{ 'n', '[h', gs.prev_hunk, 'Prev git hunk' },
				{ 'n', ']h', gs.next_hunk, 'Next git hunk' },
				{ { 'n', 'v' }, '<leader>ghr', gs.reset_hunk, 'reset hunk' },
				{ { 'n', 'v' }, '<leader>ghs', gs.stage_hunk, 'stage hunk' },
			}

			local function map(t)
				local mode, l, r, desc = unpack(t)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end

			for _, keymap in ipairs(keymaps) do
				map(keymap)
			end
		end,
	},
}
