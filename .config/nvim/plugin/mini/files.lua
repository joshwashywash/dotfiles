MiniDeps.later(function()
	local files = require('mini.files')
	files.setup({
		mappings = {
			close = '<esc>',
			go_in = '<m-right>',
			go_in_plus = '<s-right>',
			go_out = '<m-left>',
			go_out_plus = '<s-left>',
		},
	})

	local map_split = function(buf_id, lhs, direction)
		local rhs = function()
			-- Make new window and set it as target
			local cur_target = files.get_explorer_state().target_window
			local new_target = vim.api.nvim_win_call(cur_target, function()
				vim.cmd(direction .. ' split')
				return vim.api.nvim_get_current_win()
			end)

			files.set_target_window(new_target)
		end

		-- Adding `desc` will result into `show_help` entries
		local desc = 'Split ' .. direction
		vim.keymap.set('n', lhs, rhs, {
			buffer = buf_id,
			desc = desc,
		})
	end

	local notify_cursor_invalid_entry_message = 'Cursor is not on valid entry'

	-- Set focused directory as current working directory
	local set_cwd = function()
		local path = (MiniFiles.get_fs_entry() or {}).path
		if path == nil then
			return vim.notify(notify_cursor_invalid_entry_message)
		end
		vim.fn.chdir(vim.fs.dirname(path))
	end

	-- Yank in register full path of entry under cursor
	local yank_path = function()
		local path = (MiniFiles.get_fs_entry() or {}).path
		if path == nil then
			return vim.notify(notify_cursor_invalid_entry_message)
		end
		vim.fn.setreg(vim.v.register, path)
	end

	vim.api.nvim_create_autocmd('User', {
		pattern = 'MiniFilesBufferCreate',
		callback = function(args)
			local buffer = args.data.buf_id
			map_split(buffer, '<c-s>', 'belowright horizontal')
			map_split(buffer, '<c-v>', 'belowright vertical')
			vim.keymap.set('n', 'g~', set_cwd, {
				buffer = buffer,
				desc = 'Set cwd',
			})
			vim.keymap.set('n', 'gy', yank_path, {
				buffer = buffer,
				desc = 'Yank path',
			})
		end,
	})

	--- @type {lhs_suffix_key: string, rhs: function, opts: vim.keymap.set.Opts}[]
	local keymaps = {
		{
			lhs_suffix_key = 'c',
			rhs = function()
				files.open(vim.fn.stdpath('config'))
			end,
			opts = {
				desc = 'config',
			},
		},
		{
			lhs_suffix_key = 'd',
			rhs = files.open,
			opts = {
				desc = 'directory',
			},
		},
		{
			lhs_suffix_key = 'f',
			rhs = function()
				files.open(vim.api.nvim_buf_get_name(0))
			end,
			opts = {
				desc = 'file directory',
			},
		},
	}

	for _, v in ipairs(keymaps) do
		vim.keymap.set('n', '<leader>e' .. v.lhs_suffix_key, v.rhs, v.opts)
	end
end)
