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
	local name = 'rose-pine'
	add(name .. '/neovim')
	require(name).setup()
	vim.cmd.colorscheme(name)
end)

local plugins = {
	'bracketed',
	'cursorword',
	'git',
	'jump',
	'splitjoin',
	'surround',
	'visits',
	-- 'pairs',
}

for _, p in ipairs(plugins) do
	later(require('mini.' .. p).setup)
end

later(function()
	add('neovim/nvim-lspconfig')

	vim.lsp.enable({
		'html',
		'jsonls',
		'lua_ls',
		'svelte',
		'tailwindcss',
		'ts_ls',
	})

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
