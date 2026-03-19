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

-- now(function()
-- 	local name = 'rose-pine'
-- 	add(name .. '/neovim')
-- 	require(name).setup()
-- 	vim.cmd.colorscheme(name)
-- end)

now(function()
	add({
		source = 'zenbones-theme/zenbones.nvim',
		depends = {
			'rktjmp/lush.nvim',
		},
	})
	vim.cmd.colorscheme('kanagawabones')
end)

local plugins = {
	'bracketed',
	'cmdline',
	'cursorword',
	'git',
	'jump',
	'splitjoin',
	'surround',
	-- 'pairs',
}

for _, p in ipairs(plugins) do
	later(require('mini.' .. p).setup)
end

later(function()
	add('neovim/nvim-lspconfig')

	vim.lsp.config('lua_ls', {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath('config')
					and (
						vim.uv.fs_stat(path .. '/.luarc.json')
						or vim.uv.fs_stat(path .. '/.luarc.jsonc')
					)
				then
					return
				end
			end

			client.config.settings.Lua =
				vim.tbl_deep_extend('force', client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using (most
						-- likely LuaJIT in the case of Neovim)
						version = 'LuaJIT',
						-- Tell the language server how to find Lua modules same way as Neovim
						-- (see `:h lua-module-load`)
						path = {
							'lua/?.lua',
							'lua/?/init.lua',
						},
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Depending on the usage, you might want to add additional paths
							-- here.
							-- '${3rd}/luv/library',
							-- '${3rd}/busted/library',
						},
						-- Or pull in all of 'runtimepath'.
						-- NOTE: this is a lot slower and will cause issues when working on
						-- your own configuration.
						-- See https://github.com/neovim/nvim-lspconfig/issues/3189
						-- library = vim.api.nvim_get_runtime_file('', true),
					},
				})
		end,
		settings = {
			Lua = {},
		},
	})

	vim.lsp.enable({
		'denols',
		'html',
		'jsonls',
		'lua_ls',
		'mdx_analyzer',
		'svelte',
		'tailwindcss',
		'ts_ls',
	})
end)
