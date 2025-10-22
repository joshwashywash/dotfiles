local config_path = vim.fn.stdpath('config')

local source_plugin = function(fname)
	dofile(config_path .. '/plugins/' .. fname)
end

local source_mini_plugin = function(fname)
	dofile(config_path .. '/mini/' .. fname)
end

local mini_path = vim.fn.stdpath('data') .. '/site/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local origin = 'https://github.com/nvim-mini/mini.nvim'
	local clone_cmd = { 'git', 'clone', '--filter=blob:none', origin, mini_path }
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

local deps = require('mini.deps')
deps.setup()

local add, now, later = deps.add, deps.now, deps.later

later(function()
	--- @type {lhs_suffix_key: string, rhs: string|function, opts: vim.keymap.set.Opts}[]
	local keymaps = {
		{
			lhs_suffix_key = 'u',
			rhs = deps.update,
			opts = {
				desc = 'update',
			},
		},
		{
			lhs_suffix_key = 'c',
			rhs = deps.clean,
			opts = {
				desc = 'clean',
			},
		},
	}

	for _, k in ipairs(keymaps) do
		vim.keymap.set('n', '<leader>d' .. k.lhs_suffix_key, k.rhs, k.opts)
	end
end)

now(function()
	for _, fname in ipairs(vim.api.nvim_get_runtime_file('config/*.lua', true)) do
		dofile(vim.fn.fnamemodify(fname, ':.'))
	end
end)

now(function()
	local name = 'rose-pine'
	add(name .. '/neovim')
	require(name).setup()
	vim.cmd.colorscheme(name)
end)

local plugins = {
	'bracketed',
	'cursorword',
	'jump',
	'splitjoin',
	'surround',
	'visits',
	-- 'pairs',
}

for _, p in ipairs(plugins) do
	later(require('mini.' .. p).setup)
end

now(function()
	source_mini_plugin('notify.lua')
end)

later(function()
	source_mini_plugin('operators.lua')
end)

now(function()
	local icons = require('mini.icons')
	icons.setup()
	later(function()
		icons.tweak_lsp_kind('replace')
	end)
end)

later(function()
	source_mini_plugin('bufremove.lua')
end)

later(function()
	source_mini_plugin('clue.lua')
end)

later(function()
	source_mini_plugin('ai.lua')
end)

later(function()
	source_mini_plugin('pick.lua')
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
	source_mini_plugin('files.lua')
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
	source_mini_plugin('move.lua')
end)

later(function()
	add({
		checkout = 'main',
		hooks = {
			post_checkout = function()
				vim.cmd('TSUpdate')
			end,
		},
		source = 'nvim-treesitter/nvim-treesitter',
	})

	source_plugin('treesitter.lua')
end)

later(function()
	add('mfussenegger/nvim-lint')
	source_plugin('nvim-lint.lua')
end)

later(function()
	add('stevearc/conform.nvim')
	source_plugin('conform.lua')
end)

later(function()
	local lsps = {}
	for _, fname in ipairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
		local server_name = vim.fn.fnamemodify(fname, ':t:r')
		table.insert(lsps, server_name)
	end

	vim.lsp.enable(lsps)

	vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(args)
			local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

			if client:supports_method('textDocument/completion') then
				if client.server_capabilities.completionProvider then
					vim.lsp.completion.enable(true, client.id, args.buf, {
						autotrigger = true,
					})
				end
			end
		end,
		group = vim.api.nvim_create_augroup('my.lsp', {}),
	})
end)
