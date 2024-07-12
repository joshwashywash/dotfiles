local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd =
		{ 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
end

local deps = require('mini.deps')

deps.setup({ path = { package = path_package } })

local add, now, later = deps.add, deps.now, deps.later

now(function()
	vim.g.mapleader = ' '
	vim.g.maplocalleader = ' '

	vim.keymap.set('n', '<s-down>', '<c-w>j', { desc = 'go to lower window' })
	vim.keymap.set('n', '<s-left>', '<c-w>h', { desc = 'go to left window' })
	vim.keymap.set('n', '<s-right>', '<c-w>l', { desc = 'go to right window' })
	vim.keymap.set('n', '<s-up>', '<c-w>k', { desc = 'go to upper window' })

	local opts = {
		cmdheight = 0,
		fillchars = { eob = ' ' },
		incsearch = true,
		pumheight = 10,
		shiftwidth = 2,
		showmode = false,
		signcolumn = 'yes',
		splitbelow = true,
		splitright = true,
		statusline = '%f %= %m',
		tabstop = 2,
		termguicolors = true,
	}

	for key, value in pairs(opts) do
		vim.opt[key] = value
	end

	vim.diagnostic.config({
		underline = false,
		virtual_text = false,
	})
end)

now(function()
	local n = 'rose-pine'
	add(n .. '/neovim')
	require(n).setup()
	vim.cmd.colorscheme(n)
end)

now(function()
	local icons = require('mini.icons')
	icons.setup()

	local kinds = vim.lsp.protocol.CompletionItemKind
	for i, kind in ipairs(kinds) do
		kinds[i] = icons.get('lsp', kind)
	end
end)

now(function()
	local notify = require('mini.notify')
	notify.setup()

	local n = notify.make_notify()

	local disallowed_messages = {
		'No information available',
	}

	vim.notify = function(msg, ...)
		if not vim.tbl_contains(disallowed_messages, msg) then
			n(msg, ...)
		end
	end
end)

local plugins = {
	'ai',
	'bracketed',
	'cursorword',
	'diff',
	'jump',
	'operators',
	'pairs',
	'splitjoin',
	'surround',
	'visits',
}

for _, p in ipairs(plugins) do
	later(require('mini.' .. p).setup)
end

later(function()
	local bufremove = require('mini.bufremove')
	bufremove.setup()
	vim.keymap.set('n', '<leader>bq', bufremove.delete, { desc = 'quit' })
	vim.keymap.set('n', '<leader>bw', bufremove.wipeout, { desc = 'wipeout' })
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
			{ mode = 'n', keys = '<leader>g', desc = 'git' },
			{ mode = 'n', keys = '<leader>l', desc = 'lsp' },
			{ mode = 'n', keys = '<leader>p', desc = 'picks' },
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
		-- <c-h> is an alias for <bs>
		mappings = {
			force_fallback = '<a-h>',
			force_twostep = '<c-h>',
		},
	})
end)

later(function()
	local pick = require('mini.pick')
	pick.setup()

	local extra = require('mini.extra')
	extra.setup()

	--- @class Pick
	--- @field opts {desc: string}
	--- @field pick function

	--- @type { [string]: Pick}
	local picks = {
		B = { opts = { desc = 'lines in buffer' }, pick = extra.pickers.buf_lines },
		C = { opts = { desc = 'cli' }, pick = pick.builtin.cli },
		F = { opts = { desc = 'files' }, pick = pick.builtin.files },
		H = { opts = { desc = 'highlight groups' }, pick = extra.pickers.hl_groups },
		L = { opts = { desc = 'lsp' }, pick = extra.pickers.lsp },
		R = { opts = { desc = 'registers' }, pick = extra.pickers.registers },
		b = { opts = { desc = 'buffers' }, pick = pick.builtin.buffers },
		c = { opts = { desc = 'commands' }, pick = extra.pickers.commands },
		d = { opts = { desc = 'diagnostic' }, pick = extra.pickers.diagnostic },
		e = { opts = { desc = 'explorer' }, pick = extra.pickers.explorer },
		f = { opts = { desc = 'recent files' }, pick = extra.pickers.oldfiles },
		g = { opts = { desc = 'grep' }, pick = pick.builtin.grep },
		h = { opts = { desc = 'help' }, pick = pick.builtin.help },
		k = { opts = { desc = 'keymaps' }, pick = extra.pickers.keymaps },
		l = { opts = { desc = 'live grep' }, pick = pick.builtin.grep_live },
		m = { opts = { desc = 'marks' }, pick = extra.pickers.marks },
		o = { opts = { desc = 'options' }, pick = extra.pickers.options },
		p = { opts = { desc = 'highlight patterns' }, pick = extra.pickers.hipatterns },
		r = { opts = { desc = 'resume' }, pick = pick.builtin.resume },
		s = { opts = { desc = 'history' }, pick = extra.pickers.history },
		t = { opts = { desc = 'treesitter' }, pick = extra.pickers.treesitter },
		u = { opts = { desc = 'spellsuggest' }, pick = extra.pickers.spellsuggest },
		v = { opts = { desc = 'visits' }, pick = extra.pickers.visit_paths },
	}

	for key, p in pairs(picks) do
		vim.keymap.set('n', '<leader>p' .. key, p.pick, p.opts)
	end

	local hi_words = extra.gen_highlighter.words
	local hipatterns = require('mini.hipatterns')

	---@param s string
	local f = function(s)
		return {
			s,
			s:gsub('^%l', string.upper),
			string.upper(s),
		}
	end

	hipatterns.setup({
		highlighters = {
			fixme = hi_words(f('fixme'), 'MiniHipatternsFixme'),
			hack = hi_words(f('hack'), 'MiniHipatternsHack'),
			todo = hi_words(f('todo'), 'MiniHipatternsTodo'),
			note = hi_words(f('note'), 'MiniHipatternsNote'),
			hex_color = hipatterns.gen_highlighter.hex_color({
				style = 'inline',
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

	vim.keymap.set('n', '<leader>f', function()
		files.open(vim.api.nvim_buf_get_name(0))
	end, { desc = 'open files' })
end)

later(function()
	require('mini.git').setup()
	local rhs = '<cmd>lua MiniGit.show_at_cursor()<cr>'
	vim.keymap.set({ 'n', 'x' }, '<leader>gs', rhs, { desc = 'Show at cursor' })
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

later(function()
	add({
		source = 'neovim/nvim-lspconfig',
		depends = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'b0o/schemastore.nvim',
		},
	})

	---@type {[string]: {mode:string|table,rhs:function,desc:string}}
	local keymaps = {
		['<leader>lR'] = {
			mode = 'n',
			rhs = function()
				vim.cmd('LspRestart')
			end,
			desc = 'restart lsps',
		},
		['<leader>lr'] = {
			mode = 'n',
			rhs = vim.lsp.buf.rename,
			desc = 'rename',
		},
		-- gd = {
		-- 	mode = 'n',
		-- 	rhs = vim.lsp.buf.definition,
		-- 	desc = 'go to definition',
		-- },
		['<leader>la'] = {
			mode = { 'n', 'v' },
			rhs = vim.lsp.buf.code_action,
			desc = 'code action',
		},
	}

	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('LspConfig', {}),
		callback = function(event)
			for lhs, keymap in pairs(keymaps) do
				vim.keymap.set(keymap.mode, lhs, keymap.rhs, {
					desc = keymap.desc,
					buffer = event.buf,
				})
			end
		end,
	})

	require('mason').setup({
		ensure_installed = {
			'html',
			'jsonls',
			'lua_ls',
			'svelte',
			'tailwindcss',
			'tsserver',
		},
	})

	local lspconfig = require('lspconfig')

	require('mason-lspconfig').setup({
		handlers = {
			function(server_name)
				lspconfig[server_name].setup({})
			end,
			gopls = function()
				lspconfig.gopls.setup({
					settings = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				})
			end,
			jsonls = function()
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities.textDocument.completion.completionItem.snippetSupport = true
				lspconfig.jsonls.setup({
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
				lspconfig.lua_ls.setup({
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
	}

	require('conform').setup({
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
			go = {
				'goimports',
				'gofumpt',
			},
			javascript = {
				prettier,
			},
			lua = {
				'stylua',
			},
			markdown = {
				prettier,
			},
			svelte = {
				prettier,
			},
			typescript = {
				prettier,
			},
		},
	})
end)
