require('mason').setup({
	ui = {
		border = 'single',
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
	group = vim.api.nvim_create_augroup('lsp-attac', {
		clear = true,
	}),
})

local lsp = require('lspconfig')

lsp.gleam.setup({})

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
			lsp.jsonls.setup({
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
