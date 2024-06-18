local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd =
		{ 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
end

require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
	vim.g.mapleader = ' '

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
	local icons = 'nvim-web-devicons'
	add('nvim-tree/' .. icons)
	require(icons).setup()
end)

later(function()
	require('mini.ai').setup()
end)

later(function()
	require('mini.bracketed').setup()
end)

later(function()
	require('mini.bufremove').setup()
	vim.keymap.set('n', '<leader>bq', MiniBufremove.delete, { desc = 'quit' })
	vim.keymap.set('n', '<leader>bw', MiniBufremove.wipeout, { desc = 'wipeout' })
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
			{ mode = 'i', keys = '<C-r>' },
			{ mode = 'c', keys = '<C-r>' },

			-- Window commands
			{ mode = 'n', keys = '<C-w>' },

			-- `z` key
			{ mode = 'n', keys = 'z' },
			{ mode = 'x', keys = 'z' },
		},
	})
end)

later(function()
	require('mini.completion').setup()
end)

later(function()
	require('mini.cursorword').setup()
end)

later(function()
	require('mini.diff').setup()
end)

later(function()
	require('mini.pick').setup()
	local extra = require('mini.extra')
	extra.setup()

	--- @class Pick
	--- @field opts {desc: string}
	--- @field pick function

	--- @type { [string]: Pick}
	local picks = {
		B = { opts = { desc = 'lines in buffer' }, pick = MiniExtra.pickers.buf_lines },
		C = { opts = { desc = 'cli' }, pick = MiniPick.builtin.cli },
		F = { opts = { desc = 'files' }, pick = MiniPick.builtin.files },
		H = { opts = { desc = 'highlight groups' }, pick = MiniExtra.pickers.hl_groups },
		L = { opts = { desc = 'lsp' }, pick = MiniExtra.pickers.lsp },
		R = { opts = { desc = 'registers' }, pick = MiniExtra.pickers.registers },
		b = { opts = { desc = 'buffers' }, pick = MiniPick.builtin.buffers },
		c = { opts = { desc = 'commands' }, pick = MiniExtra.pickers.commands },
		d = { opts = { desc = 'diagnostic' }, pick = MiniExtra.pickers.diagnostic },
		e = { opts = { desc = 'explorer' }, pick = MiniExtra.pickers.explorer },
		f = { opts = { desc = 'recent files' }, pick = MiniExtra.pickers.oldfiles },
		g = { opts = { desc = 'grep' }, pick = MiniPick.builtin.grep },
		h = { opts = { desc = 'help' }, pick = MiniPick.builtin.help },
		k = { opts = { desc = 'keymaps' }, pick = MiniExtra.pickers.keymaps },
		l = { opts = { desc = 'live grep' }, pick = MiniPick.builtin.grep_live },
		m = { opts = { desc = 'marks' }, pick = MiniExtra.pickers.marks },
		o = { opts = { desc = 'options' }, pick = MiniExtra.pickers.options },
		p = { opts = { desc = 'highlight patterns' }, pick = MiniExtra.pickers.hipatterns },
		r = { opts = { desc = 'resume' }, pick = MiniPick.builtin.resume },
		s = { opts = { desc = 'history' }, pick = MiniExtra.pickers.history },
		t = { opts = { desc = 'treesitter' }, pick = MiniExtra.pickers.treesitter },
		u = { opts = { desc = 'spellsuggest' }, pick = MiniExtra.pickers.spellsuggest },
		v = { opts = { desc = 'visits' }, pick = MiniExtra.pickers.visit_paths },
	}

	for key, pick in pairs(picks) do
		vim.keymap.set('n', '<leader>p' .. key, pick.pick, pick.opts)
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
	require('mini.files').setup({
		mappings = {
			close = '<esc>',
			go_in = '<m-right>',
			go_in_plus = '<s-right>',
			go_out = '<m-left>',
			go_out_plus = '<s-left>',
		},
	})

	vim.keymap.set('n', '<leader>f', function()
		MiniFiles.open(vim.api.nvim_buf_get_name(0))
	end, { desc = 'open files' })
end)

later(function()
	require('mini.git').setup()
	local rhs = '<cmd>lua MiniGit.show_at_cursor()<cr>'
	vim.keymap.set({ 'n', 'x' }, '<leader>gs', rhs, { desc = 'Show at cursor' })
end)

later(function()
	require('mini.jump').setup()
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
	require('mini.operators').setup()
end)

later(function()
	require('mini.pairs').setup()
end)

later(function()
	require('mini.splitjoin').setup()
end)

later(function()
	require('mini.surround').setup()
end)

later(function()
	require('mini.visits').setup()
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
			'html',
			'javascript',
			'jsdoc',
			'json',
			'lua',
			'markdown',
			'markdown_inline',
			'svelte',
			'typescript',
			'vim',
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

	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('LspConfig', {}),
		callback = function(event)
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
				gd = {
					mode = 'n',
					rhs = vim.lsp.buf.declaration,
					desc = 'go to declaration',
				},
				['<leader>la'] = {
					mode = { 'n', 'v' },
					rhs = vim.lsp.buf.code_action,
					desc = 'code action',
				},
			}

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
			['jsonls'] = function()
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
			['lua_ls'] = function()
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
	add('onsails/lspkind.nvim')
	require('lspkind').init({
		mode = 'symbol',
	})
end)

later(function()
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

	add('stevearc/conform.nvim')

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
			return { timeout_ms = 500, lsp_fallback = true }
		end,
		formatters_by_ft = {
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
