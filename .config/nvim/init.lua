local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd =
		{ 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
end

vim.filetype.add({
	extension = {
		mdx = 'markdown',
	},
})

vim.g.markdown_fenced_languages = {
	'ts=typescript',
}

local deps = require('mini.deps')

deps.setup({ path = { package = path_package } })

local add, now, later = deps.add, deps.now, deps.later

now(function()
	vim.g.mapleader = ' '
	vim.g.maplocalleader = ' '

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

	vim.o.cmdheight = 0
	vim.o.incsearch = true
	vim.o.pumheight = 4
	vim.o.shiftwidth = 2
	vim.o.signcolumn = 'yes'
	vim.o.splitbelow = true
	vim.o.splitright = true
	vim.o.statusline = '%f %= %m'
	vim.o.tabstop = 2
	vim.o.termguicolors = true
	vim.opt.fillchars = { eob = ' ' }

	vim.diagnostic.config({
		underline = false,
		virtual_text = false,
		float = {
			border = 'single',
		},
	})
end)

now(function()
	-- local n = 'rose-pine'
	-- add(n .. '/neovim')
	-- require(n).setup()
	-- vim.cmd.colorscheme(n)

	require('mini.hues').setup({
		background = '#222222',
		foreground = '#f8f8f8',
		saturation = 'high',
	})
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

	---@param notify function
	local create_notify = function(notify)
		local disallowed_messages = {
			'No information available',
		}

		---@param msg string
		return function(msg, ...)
			if not vim.tbl_contains(disallowed_messages, msg) then
				notify(msg, ...)
			end
		end
	end

	vim.notify = create_notify(mini_notify.make_notify())
end)

local plugins = {
	'bracketed',
	'cursorword',
	'jump',
	'operators',
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
	---@type {lhs_suffix_key: string, rhs: string|function, opts: vim.keymap.set.Opts}[]
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
		-- <c-h> is an alias for <bs>
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

	require('mini.ai').setup({
		custom_textobjects = {
			B = gen_ai_spec.buffer(),
			D = gen_ai_spec.diagnostic(),
			I = gen_ai_spec.indent(),
			L = gen_ai_spec.line(),
			N = gen_ai_spec.number(),
		},
	})
end)

later(function()
	local pick = require('mini.pick')

	pick.setup()
	vim.ui.select = pick.ui_select

	local pickers = require('mini.extra').pickers

	--- @type {lhs_suffix_key: string, rhs: string|function, opts: vim.keymap.set.Opts}[]
	local picks = {
		{
			lhs_suffix_key = 'B',
			rhs = pickers.buf_lines,
			opts = {
				desc = 'lines in buffer',
			},
		},
		{
			lhs_suffix_key = 'F',
			rhs = pick.builtin.files,
			opts = {
				desc = 'files',
			},
		},
		{
			lhs_suffix_key = 'H',
			rhs = pickers.hl_groups,
			opts = {
				desc = 'highlight groups',
			},
		},
		{
			lhs_suffix_key = 'R',
			rhs = pickers.registers,
			opts = {
				desc = 'registers',
			},
		},
		{
			lhs_suffix_key = 'b',
			rhs = pick.builtin.buffers,
			opts = {
				desc = 'buffers',
			},
		},
		{
			lhs_suffix_key = 'c',
			rhs = pickers.commands,
			opts = {
				desc = 'commands',
			},
		},
		{
			lhs_suffix_key = 'd',
			rhs = pickers.diagnostic,
			opts = {
				desc = 'diagnostic',
			},
		},
		{
			lhs_suffix_key = 'e',
			rhs = pickers.explorer,
			opts = {
				desc = 'explorer',
			},
		},
		{
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
			lhs_suffix_key = 'g',
			rhs = pick.builtin.grep_live,
			opts = {
				desc = 'live grep',
			},
		},
		{
			lhs_suffix_key = 'h',
			rhs = pick.builtin.help,
			opts = {
				desc = 'help',
			},
		},
		{
			lhs_suffix_key = 'k',
			rhs = pickers.keymaps,
			opts = {
				desc = 'keymaps',
			},
		},
		{
			lhs_suffix_key = 'm',
			rhs = pickers.marks,
			opts = {
				desc = 'marks',
			},
		},
		{
			lhs_suffix_key = 'o',
			rhs = pickers.options,
			opts = {
				desc = 'options',
			},
		},
		{
			lhs_suffix_key = 'p',
			rhs = pickers.hipatterns,
			opts = {
				desc = 'highlight patterns',
			},
		},
		{
			lhs_suffix_key = 'r',
			rhs = pick.builtin.resume,
			opts = {
				desc = 'resume',
			},
		},
		{
			lhs_suffix_key = 's',
			rhs = pickers.history,
			opts = {
				desc = 'history',
			},
		},
		{
			lhs_suffix_key = 't',
			rhs = pickers.treesitter,
			opts = {
				desc = 'treesitter',
			},
		},
		{
			lhs_suffix_key = 'u',
			rhs = pickers.spellsuggest,
			opts = {
				desc = 'spellsuggest',
			},
		},
		{
			lhs_suffix_key = 'v',
			rhs = pickers.visit_paths,
			opts = {
				desc = 'visits',
			},
		},
	}

	for _, p in ipairs(picks) do
		vim.keymap.set('n', '<leader>f' .. p.lhs_suffix_key, p.rhs, p.opts)
	end
end)

later(function()
	local hi_words = require('mini.extra').gen_highlighter.words

	---@param s string
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

	vim.api.nvim_create_autocmd('User', {
		pattern = 'MiniFilesBufferCreate',
		callback = function(args)
			local buf_id = args.data.buf_id
			map_split(buf_id, '<c-s>', 'belowright horizontal')
			map_split(buf_id, '<c-v>', 'belowright vertical')
		end,
	})

	---@ type {lhs_suffix_key: string, rhs: function, opts: vim.keymap.set.Opts}[]
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
			-- vim diagnostic signs have a default priority of 10
			priority = 9,
		},
	})

	---@type {lhs_suffix_key: string, rhs: string|function, opts: vim.keymap.set.Opts}[]
	local keymaps = {
		{
			lhs_suffix_key = 'c',
			rhs = '<cmd>Git commit<cr>',
			opts = {
				desc = 'commit',
			},
		},
		{
			lhs_suffix_key = 'C',
			rhs = '<cmd>Git commit --amend<cr>',
			opts = {
				desc = 'amend commit',
			},
		},
		{
			lhs_suffix_key = 'o',
			rhs = diff.toggle_overlay,
			opts = {
				desc = 'toggle overlay',
			},
		},
		{
			lhs_suffix_key = 's',
			rhs = git.show_at_cursor,
			opts = {
				desc = 'show at cursor',
			},
		},
	}

	for _, v in ipairs(keymaps) do
		vim.keymap.set('n', '<leader>g' .. v.lhs_suffix_key, v.rhs, v.opts)
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
	require('nvim-treesitter.configs').setup({
		ensure_installed = {
			'astro',
			'css',
			'dart',
			'go',
			'html',
			'javascript',
			'jsdoc',
			'json',
			'lua',
			'markdown',
			'markdown_inline',
			'svelte',
			'tsx',
			'typescript',
			'vimdoc',
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<leader>n',
				node_incremental = 'n',
				node_decremental = 'N',
				scope_incremental = false,
			},
		},
		highlight = {
			additional_vim_regex_highlighting = false,
			enable = true,
		},
	})
end)

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

local open_floating_preview = function(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or 'single'
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.lsp.util.open_floating_preview = open_floating_preview

later(function()
	add({
		source = 'neovim/nvim-lspconfig',
		depends = {
			'b0o/schemastore.nvim',
			'williamboman/mason-lspconfig.nvim',
			'williamboman/mason.nvim',
		},
	})

	---@type {mode: string|string[], lhs_suffix_key: string, rhs: string|function, opts: vim.keymap.set.Opts}[]
	local keymaps = {
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
			lhs_suffix_key = 'r',
			rhs = vim.lsp.buf.rename,
			opts = {
				desc = 'rename',
			},
		},
		{
			mode = { 'n', 'v' },
			lhs_suffix_key = 'a',
			rhs = vim.lsp.buf.code_action,
			opts = {
				desc = 'code action',
			},
		},
	}

	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('LspConfig', {}),
		callback = function(event)
			local bufnr = event.buf
			vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
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
						local path = client.workspace_folders[1].name
						if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
							return
						end

						client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
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
									-- "${3rd}/luv/library"
									-- "${3rd}/busted/library",
								},
								-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
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
	add('stevearc/conform.nvim')
	vim.api.nvim_create_user_command('FormatDisable', function(args)
		if args.bang then
			-- FormatDisable! will disable formatting just for this buffer
			vim.b.disable_autoformat = true
		else
			vim.g.disable_autoformat = true
		end
	end, {
		desc = 'Disable autoformat-on-save',
		bang = true,
	})
	vim.api.nvim_create_user_command('FormatEnable', function()
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
	end, {
		desc = 'Enable autoformat-on-save',
	})

	local prettier = {
		'prettierd',
		'prettier',
		stop_after_first = true,
	}

	local conform = require('conform')

	---@param bufnr integer
	---@param ... string
	---@return string
	local function first(bufnr, ...)
		for i = 1, select('#', ...) do
			local formatter = select(i, ...)
			if conform.get_formatter_info(formatter, bufnr).available then
				return formatter
			end
		end
		return select(1, ...)
	end

	conform.setup({
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return {
				timeout_ms = 500,
				lsp_format = 'fallback',
			}
		end,
		formatters_by_ft = {
			astro = { 'prettier' },
			go = {
				'goimports',
				'gofumpt',
			},
			javascript = prettier,
			lua = {
				'stylua',
			},
			markdown = function(bufnr)
				return { first(bufnr, 'prettierd', 'prettier'), 'injected' }
			end,
			svelte = prettier,
			typescript = prettier,
		},
	})
end)
