--- @class Pick
--- @field pick string
--- @field opts {desc:string}
--- @field key string

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
	}

	for key, value in pairs(opts) do
		vim.opt[key] = value
	end

	vim.diagnostic.config({
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
			{ mode = 'n', keys = '<leader>l', desc = 'lsp' },
			{ mode = 'n', keys = '<leader>e', desc = 'explore' },
			{ mode = 'n', keys = '[b', postkeys = '[' },
			{ mode = 'n', keys = '[w', postkeys = '[' },
			{ mode = 'n', keys = ']b', postkeys = ']' },
			{ mode = 'n', keys = ']w', postkeys = ']' },
		},
		triggers = {
			{ mode = 'n', keys = ']' },
			{ mode = 'n', keys = '[' },

			-- Leader triggers
			{ mode = 'n', keys = '<Leader>' },
			{ mode = 'x', keys = '<Leader>' },

			-- Built-in completion
			{ mode = 'i', keys = '<C-x>' },

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
	require('mini.comment').setup()
end)

later(function()
	require('mini.completion').setup({
		lsp_completion = {
			source_func = 'omnifunc',
			auto_setup = false,
		},
	})
end)

later(function()
	require('mini.cursorword').setup()
end)

later(function()
	require('mini.diff').setup()
end)

later(function()
	local extra = require('mini.extra')
	extra.setup()

	---@type Pick[]
	local picks = {
		{
			key = 'B',
			opts = {
				desc = 'lines in buffer',
			},
			pick = MiniExtra.pickers.buf_lines,
		},
		{
			key = 'C',
			opts = {
				desc = 'commands',
			},
			pick = MiniExtra.pickers.commands,
		},
		{
			key = 'D',
			opts = {
				desc = 'diagnostic',
			},
			pick = MiniExtra.pickers.diagnostic,
		},
		{
			key = 'E',
			opts = {
				desc = 'explorer',
			},
			pick = MiniExtra.pickers.explorer,
		},
		{
			key = 'P',
			opts = {
				desc = 'highlight patterns',
			},
			pick = MiniExtra.pickers.hipatterns,
		},
		{
			key = 'S',
			opts = {
				desc = 'history',
			},
			pick = MiniExtra.pickers.history,
		},
		{
			key = 'H',
			opts = {
				desc = 'highlight groups',
			},
			pick = MiniExtra.pickers.hl_groups,
		},
		{
			key = 'K',
			opts = {
				desc = 'keymaps',
			},
			pick = MiniExtra.pickers.keymaps,
		},
		{
			key = 'L',
			opts = {
				desc = 'lsp',
			},
			pick = MiniExtra.pickers.lsp,
		},
		{
			key = 'M',
			opts = {
				desc = 'marks',
			},
			pick = MiniExtra.pickers.marks,
		},
		{
			key = 'F',
			opts = {
				desc = 'recent files',
			},
			pick = MiniExtra.pickers.oldfiles,
		},
		{
			key = 'O',
			opts = {
				desc = 'options',
			},
			pick = MiniExtra.pickers.options,
		},
		{
			key = 'G',
			opts = {
				desc = 'registers',
			},
			pick = MiniExtra.pickers.registers,
		},
		{
			key = 'T',
			opts = {
				desc = 'treesitter',
			},
			pick = MiniExtra.pickers.treesitter,
		},
		{
			key = 'U',
			opts = {
				desc = 'spellsuggest',
			},
			pick = MiniExtra.pickers.spellsuggest,
		},
		{
			key = 'V',
			opts = {
				desc = 'visits',
			},
			pick = MiniExtra.pickers.visit_paths,
		},
	}

	for _, pick in ipairs(picks) do
		vim.keymap.set('n', '<leader>e' .. pick.key, pick.pick, pick.opts)
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
			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end)

later(function()
	require('mini.fuzzy').setup()
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
	require('mini.jump').setup()
end)

later(function()
	require('mini.pick').setup()

	---@type Pick[]
	local picks = {
		{
			key = 'b',
			opts = {
				desc = 'buffers',
			},
			pick = MiniPick.builtin.buffers,
		},
		{
			key = 'c',
			opts = {
				desc = 'cli',
			},
			pick = MiniPick.builtin.cli,
		},
		{
			key = 'f',
			opts = {
				desc = 'files',
			},
			pick = MiniPick.builtin.files,
		},
		{
			key = 'g',
			opts = {
				desc = 'grep',
			},
			pick = MiniPick.builtin.grep,
		},
		{
			key = 'l',
			opts = {
				desc = 'live grep',
			},
			pick = MiniPick.builtin.grep_live,
		},
		{
			key = 'h',
			opts = {
				desc = 'help',
			},
			pick = MiniPick.builtin.help,
		},
		{
			key = 'r',
			opts = {
				desc = 'resume',
			},
			pick = MiniPick.builtin.resume,
		},
	}

	for _, pick in ipairs(picks) do
		vim.keymap.set('n', '<leader>e' .. pick.key, pick.pick, pick.opts)
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
	add({ source = 'neovim/nvim-lspconfig', depends = { 'williamboman/mason.nvim' } })
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
			vim.bo[event.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

			---@type {mode:string|table,lhs:string,rhs:function,desc:string}[]
			local keymaps = {
				{
					mode = 'n',
					lhs = '<c-k>',
					rhs = vim.lsp.buf.signature_help,
					desc = 'signature help',
				},
				{
					mode = 'n',
					lhs = '<leader>lR',
					rhs = function()
						vim.cmd('LspRestart')
					end,
					desc = 'restart lsps',
				},
				{
					mode = 'n',
					lhs = '<leader>lf',
					rhs = function()
						vim.lsp.buf.format({ async = true })
					end,
					desc = 'format',
				},
				{
					mode = 'n',
					lhs = '<leader>lr',
					rhs = vim.lsp.buf.rename,
					desc = 'rename',
				},
				{
					mode = 'n',
					lhs = 'K',
					rhs = vim.lsp.buf.hover,
					desc = 'hover',
				},
				{
					mode = 'n',
					lhs = 'gD',
					rhs = vim.lsp.buf.declaration,
					desc = 'go to declaration',
				},
				{
					mode = 'n',
					lhs = 'gd',
					rhs = vim.lsp.buf.definition,
					desc = 'go to definition',
				},
				{
					mode = 'n',
					lhs = 'gl',
					rhs = vim.lsp.buf.implementation,
					desc = 'go to implementation',
				},
				{
					mode = { 'n', 'v' },
					lhs = '<leader>la',
					rhs = vim.lsp.buf.code_action,
					desc = 'code action',
				},
			}

			for _, keymap in ipairs(keymaps) do
				vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, { desc = keymap.desc, buffer = event.buf })
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
			['jsonls'] = function()
				lspconfig.jsonls.setup({
					settings = {
						json = {
							schemas = require('schemastore').json.schemas(),
							validate = { enable = true },
						},
					},
				})
			end,
			['lua_ls'] = function()
				lspconfig.lua_ls.setup({
					on_init = function(client)
						local path = client.workspace_folders[1].name
						if
							not vim.loop.fs_stat(path .. '/.luarc.json')
							and not vim.loop.fs_stat(path .. '/.luarc.jsonc')
						then
							client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
								Lua = {
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
											-- E.g.: For using `vim.*` functions, add vim.env.VIMRUNTIME/lua.
											-- "${3rd}/luv/library"
											-- "${3rd}/busted/library",
										},
										-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
										-- library = vim.api.nvim_get_runtime_file("", true)
									},
								},
							})
						end
						return true
					end,
				})
			end,
			function(server_name)
				lspconfig[server_name].setup({})
			end,
		},
	})
end)

later(function()
	add('onsails/lspkind.nvim')
	require('lspkind').init({ mode = 'symbol' })
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
	require('conform').setup({
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_fallback = true }
		end,
		formatters_by_ft = {
			javascript = { { 'prettierd', 'prettier' } },
			lua = { 'stylua' },
			markdown = { { 'prettierd', 'prettier' } },
			svelte = { { 'prettierd', 'prettier' } },
			typescript = { { 'prettierd', 'prettier' } },
		},
	})
end)
