_G.Config = {
	path_package = vim.fn.stdpath('data') .. '/site/',
	path_source = vim.fn.stdpath('config') .. '/src/',
}

--- @param path string
local source_file = function(path)
	dofile(Config.path_source .. path)
end

local mini_path = Config.path_package .. 'pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/echasnovski/mini.nvim',
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
end

local deps = require('mini.deps')

deps.setup({ path = { package = Config.path_package } })

local add, now, later = deps.add, deps.now, deps.later

now(function()
	source_file('settings.lua')
end)

now(function()
	source_file('filetypes.lua')
end)

now(function()
	--- @type {direction: string, lhs_suffix_key: string, rhs_suffix_key: string}[]
	local window_focus_keymaps = {
		{
			direction = 'lower',
			lhs_suffix_key = 'down',
			rhs_suffix_key = 'j',
		},
		{
			direction = 'left',
			lhs_suffix_key = 'left',
			rhs_suffix_key = 'h',
		},
		{
			direction = 'right',
			lhs_suffix_key = 'right',
			rhs_suffix_key = 'l',
		},
		{
			direction = 'upper',
			lhs_suffix_key = 'up',
			rhs_suffix_key = 'k',
		},
	}

	for _, v in ipairs(window_focus_keymaps) do
		vim.keymap.set(
			'n',
			'<s-' .. v.lhs_suffix_key .. '>',
			'<c-w>' .. v.rhs_suffix_key,
			{ desc = 'focus' .. v.direction .. 'window' }
		)
	end
end)

now(function()
	local n = 'rose-pine'
	add(n .. '/neovim')
	require(n).setup()
	vim.cmd.colorscheme(n .. '-moon')
end)

now(function()
	local mini_notify = require('mini.notify')
	mini_notify.setup({
		window = {
			config = function()
				local has_statusline = vim.o.laststatus > 0
				local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
				return {
					anchor = 'SE',
					col = vim.o.columns,
					row = vim.o.lines - pad,
				}
			end,
		},
	})

	-- --- @param notify function
	-- local create_notify = function(notify)
	-- 	local disallowed_messages = {
	-- 		'No information available',
	-- 	}
	--
	-- 	--- @param msg string
	-- 	return function(msg, ...)
	-- 		if not vim.tbl_contains(disallowed_messages, msg) then
	-- 			notify(msg, ...)
	-- 		end
	-- 	end
	-- end
	--
	-- vim.notify = create_notify(mini_notify.make_notify())
end)

later(function()
	vim.api.nvim_create_autocmd('TextYankPost', {
		callback = function()
			vim.highlight.on_yank()
		end,
		desc = 'highlight on yank',
		group = vim.api.nvim_create_augroup('highlight-on-yank', { clear = true }),
	})
end)

later(function()
	local prefix = '<leader>o'
	require('mini.operators').setup({
		evaluate = {
			prefix = prefix .. '=',
		},
		exchange = {
			prefix = prefix .. 'x',
		},
		multiply = {
			prefix = prefix .. 'm',
		},
		replace = {
			prefix = prefix .. 'or',
			reindent_linewise = true,
		},
		sort = {
			prefix = prefix .. 's',
		},
	})
end)

local plugins = {
	'bracketed',
	'cursorword',
	'jump',
	-- 'pairs',
	'pick',
	'splitjoin',
	'surround',
	'visits',
}

for _, p in ipairs(plugins) do
	later(require('mini.' .. p).setup)
end

later(function()
	--- @type {lhs_suffix_key: string, rhs: string|function, opts: vim.keymap.set.Opts}[]
	local keymaps = {
		{
			lhs_suffix_key = 'u',
			rhs = deps.update,
			opts = { desc = 'update' },
		},
		{
			lhs_suffix_key = 'c',
			rhs = deps.clean,
			opts = { desc = 'clean' },
		},
	}

	for _, k in ipairs(keymaps) do
		vim.keymap.set('n', '<leader>d' .. k.lhs_suffix_key, k.rhs, k.opts)
	end
end)

later(function()
	local icons = require('mini.icons')
	icons.setup()
	icons.tweak_lsp_kind('replace')
end)

later(function()
	local bufremove = require('mini.bufremove')
	bufremove.setup()
	vim.keymap.set('n', '<leader>be', bufremove.delete, { desc = 'delete' })
end)

later(function()
	local clue = require('mini.clue')
	clue.setup({
		clues = {
			clue.gen_clues.builtin_completion(),
			clue.gen_clues.g(),
			clue.gen_clues.marks(),
			clue.gen_clues.registers(),
			clue.gen_clues.windows({ submode_resize = true }),
			clue.gen_clues.z(),
			{ mode = 'n', keys = '<leader>b', desc = 'buffer' },
			{ mode = 'n', keys = '<leader>d', desc = 'deps' },
			{ mode = 'n', keys = '<leader>e', desc = 'explore' },
			{ mode = 'n', keys = '<leader>f', desc = 'find' },
			{ mode = 'n', keys = '<leader>g', desc = 'git' },
			{ mode = 'n', keys = '<leader>l', desc = 'lsp' },
			{ mode = 'x', keys = '<leader>l', desc = 'lsp' },
			{ mode = 'n', keys = '<leader>o', desc = 'operators' },
			{ mode = 'x', keys = '<leader>o', desc = 'operators' },
			{ mode = 'n', keys = '[b', postkeys = '[' },
			{ mode = 'n', keys = '[w', postkeys = '[' },
			{ mode = 'n', keys = ']b', postkeys = ']' },
			{ mode = 'n', keys = ']w', postkeys = ']' },
		},
		triggers = {
			{ mode = 'n', keys = ']' },
			{ mode = 'n', keys = '[' },

			-- Leader triggers
			{ mode = 'n', keys = '<leader>' },
			{ mode = 'x', keys = '<leader>' },

			-- Built-in completion
			{ mode = 'i', keys = '<c-x>' },

			-- `g` key
			{ mode = 'n', keys = 'g' },
			{ mode = 'x', keys = 'g' },

			-- Marks
			{ mode = 'n', keys = "'" },
			{ mode = 'n', keys = '`' },
			{ mode = 'x', keys = "'" },
			{ mode = 'x', keys = '`' },

			-- Registers
			{ mode = 'n', keys = '"' },
			{ mode = 'x', keys = '"' },
			{ mode = 'i', keys = '<c-r>' },
			{ mode = 'c', keys = '<c-r>' },

			-- Window commands
			{ mode = 'n', keys = '<c-w>' },

			-- `z` key
			{ mode = 'n', keys = 'z' },
			{ mode = 'x', keys = 'z' },
		},
	})
end)

later(function()
	require('mini.completion').setup({
		lsp_completion = {
			auto_setup = false,
			source_func = 'omnifunc',
		},
		mappings = {
			force_fallback = '<a-h>',
			force_twostep = '<c-h>',
		},
		window = {
			info = {
				border = 'single',
			},
			signature = {
				border = 'single',
			},
		},
	})
end)

later(function()
	local gen_ai_spec = require('mini.extra').gen_ai_spec
	local ai = require('mini.ai')

	ai.setup({
		custom_textobjects = {
			B = gen_ai_spec.buffer(),
			D = gen_ai_spec.diagnostic(),
			F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
			I = gen_ai_spec.indent(),
			L = gen_ai_spec.line(),
			N = gen_ai_spec.number(),
			o = ai.gen_spec.treesitter({
				a = { '@conditional.outer', '@loop.outer' },
				i = { '@conditional.inner', '@loop.inner' },
			}),
		},
	})
end)

later(function()
	local pick = require('mini.pick')
	pick.setup()
	vim.ui.select = pick.ui_select

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

later(function()
	local hi_words = require('mini.extra').gen_highlighter.words

	--- @param s string
	local f = function(s)
		return {
			s,
			s:gsub('^%l', string.upper),
			string.upper(s),
		}
	end

	local hipatterns = require('mini.hipatterns')
	hipatterns.setup({
		highlighters = {
			fixme = hi_words(f('fixme'), 'MiniHipatternsFixme'),
			hack = hi_words(f('hack'), 'MiniHipatternsHack'),
			todo = hi_words(f('todo'), 'MiniHipatternsTodo'),
			note = hi_words(f('note'), 'MiniHipatternsNote'),
			hex_color = hipatterns.gen_highlighter.hex_color({
				style = 'bg',
			}),
		},
	})
end)

later(function()
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
		vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
	end

	local set_cwd = function()
		local path = files.get_fs_entry().path
		if path ~= nil then
			vim.fn.chdir(vim.fs.dirname(path))
		else
			vim.notify('Cursor is not on valid entry')
		end
	end

	local yank_path = function()
		local path = files.get_fs_entry().path
		if path ~= nil then
			vim.fn.setreg(vim.v.register, path)
		end
	end

	vim.api.nvim_create_autocmd('User', {
		pattern = 'MiniFilesBufferCreate',
		callback = function(args)
			local buffer = args.data.buf_id
			map_split(buffer, '<c-s>', 'belowright horizontal')
			map_split(buffer, '<c-v>', 'belowright vertical')
			vim.keymap.set('n', 'g~', set_cwd, { buffer = buffer, desc = 'Set cwd' })
			vim.keymap.set('n', 'gy', yank_path, { buffer = buffer, desc = 'Yank path' })
		end,
	})

	--- @type {lhs_suffix_key: string, rhs: function, opts: vim.keymap.set.Opts}[]
	local keymaps = {
		{
			lhs_suffix_key = 'c',
			rhs = function()
				files.open(vim.fn.stdpath('config'))
			end,
			opts = { desc = 'config' },
		},
		{
			lhs_suffix_key = 'd',
			rhs = files.open,
			opts = { desc = 'directory' },
		},
		{
			lhs_suffix_key = 'f',
			rhs = function()
				files.open(vim.api.nvim_buf_get_name(0))
			end,
			opts = { desc = 'file directory' },
		},
	}

	for _, v in ipairs(keymaps) do
		vim.keymap.set('n', '<leader>e' .. v.lhs_suffix_key, v.rhs, v.opts)
	end
end)

later(function()
	local git = require('mini.git')
	git.setup()

	local diff = require('mini.diff')
	diff.setup({
		view = {
			priority = vim.diagnostic.config().signs.priority - 1,
		},
	})

	--- @type {mode: string|string[], lhs_suffix_key: string, rhs: string|function, opts: vim.keymap.set.Opts}[]
	local keymaps = {
		{
			mode = 'n',
			lhs_suffix_key = 'c',
			rhs = '<cmd>Git commit<cr>',
			opts = {
				desc = 'commit',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'C',
			rhs = '<cmd>Git commit --amend<cr>',
			opts = {
				desc = 'amend commit',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'o',
			rhs = diff.toggle_overlay,
			opts = {
				desc = 'toggle overlay',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 's',
			rhs = git.show_at_cursor,
			opts = {
				desc = 'show at cursor',
			},
		},
	}

	for _, v in ipairs(keymaps) do
		vim.keymap.set(v.mode, '<leader>g' .. v.lhs_suffix_key, v.rhs, v.opts)
	end
end)

later(function()
	require('mini.move').setup({
		mappings = {
			down = '<m-down>',
			left = '<m-left>',
			right = '<m-right>',
			up = '<m-up>',

			line_down = '<m-down>',
			line_left = '<m-left>',
			line_right = '<m-right>',
			line_up = '<m-up>',
		},
	})
end)

later(function()
	add({
		checkout = 'master',
		hooks = {
			post_checkout = function()
				vim.cmd('TSUpdate')
			end,
		},
		monitor = 'main',
		source = 'nvim-treesitter/nvim-treesitter',
	})
	source_file('plugins/treesitter.lua')
end)

later(function()
	add({
		source = 'neovim/nvim-lspconfig',
		depends = {
			'b0o/schemastore.nvim',
			'williamboman/mason-lspconfig.nvim',
			'williamboman/mason.nvim',
		},
	})

	--- @type {mode: string|string[], lhs_suffix_key: string, rhs: string|function, opts: vim.keymap.set.Opts}[]
	local keymaps = {
		{
			mode = { 'n', 'v' },
			lhs_suffix_key = 'a',
			rhs = vim.lsp.buf.code_action,
			opts = {
				desc = 'code action',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'R',
			rhs = function()
				vim.cmd('LspRestart')
			end,
			opts = {
				desc = 'restart lsps',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'I',
			rhs = function()
				vim.cmd('check lspconfig')
			end,
			opts = {
				desc = 'info',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'r',
			rhs = vim.lsp.buf.rename,
			opts = {
				desc = 'rename',
			},
		},
		{
			mode = 'n',
			lhs_suffix_key = 'S',
			rhs = function()
				vim.cmd('LspStop')
			end,
			opts = {
				desc = 'stop',
			},
		},
	}

	vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(event)
			local bufnr = event.buf
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client then
				if client.server_capabilities.completionProvider then
					vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
				end
				-- let conform handle formatting
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end
			for _, v in ipairs(keymaps) do
				v.opts.buffer = bufnr
				vim.keymap.set(v.mode, '<leader>l' .. v.lhs_suffix_key, v.rhs, v.opts)
			end
		end,
	})

	require('mason').setup({
		ui = {
			border = 'single',
		},
	})

	local lsp = require('lspconfig')

	require('mason-lspconfig').setup({
		ensure_installed = {
			'html',
			'jsonls',
			'lua_ls',
			'svelte',
			'tailwindcss',
			'ts_ls',
		},
		handlers = {
			function(server_name)
				lsp[server_name].setup({})
			end,
			gopls = function()
				lsp.gopls.setup({
					settings = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				})
			end,
			denols = function()
				lsp.denols.setup({
					root_dir = lsp.util.root_pattern('deno.json', 'deno.jsonc'),
				})
			end,
			jsonls = function()
				-- TODO remove capabilities when mini.snippets is out?
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities.textDocument.completion.completionItem.snippetSupport = true
				lsp.jsonls.setup({
					capabilities = capabilities,
					settings = {
						json = {
							schemas = require('schemastore').json.schemas(),
							validate = {
								enable = true,
							},
						},
					},
				})
			end,
			lua_ls = function()
				lsp.lua_ls.setup({
					on_init = function(client)
						if client.workspace_folders then
							local path = client.workspace_folders[1].name
							if
								vim.uv.fs_stat(path .. '/.luarc.json')
								or vim.uv.fs_stat(path .. '/.luarc.jsonc')
							then
								return
							end
						end

						client.config.settings.Lua =
							vim.tbl_deep_extend('force', client.config.settings.Lua, {
								runtime = {
									-- Tell the language server which version of Lua you're using
									-- (most likely LuaJIT in the case of Neovim)
									version = 'LuaJIT',
								},
								-- Make the server aware of Neovim runtime files
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
										-- Depending on the usage, you might want to add additional paths here.
										'${3rd}/luv/library',
										-- "${3rd}/busted/library",
									},
									-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
									-- library = vim.api.nvim_get_runtime_file("", true)
								},
							})
					end,
					settings = {
						Lua = {},
					},
				})
			end,
			ts_ls = function()
				lsp.ts_ls.setup({
					root_dir = lsp.util.root_pattern('package.json'),
					single_file_support = false,
				})
			end,
		},
	})
end)

later(function()
	add('mfussenegger/nvim-lint')
	source_file('plugins/nvim-lint.lua')
end)

later(function()
	add('stevearc/conform.nvim')
	source_file('/plugins/conform.lua')
end)
