require('mason').setup()

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client == nil then
			return
		end

		if client:supports_method('textDocument/completion') then
			if client.server_capabilities.completionProvider then
				vim.lsp.completion.enable(true, client.id, event.buf, {
					autotrigger = true,
				})
			end
		end
	end,
	group = vim.api.nvim_create_augroup('', {}),
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
							path ~= vim.fn.stdpath('config')
							and (
								vim.loop.fs_stat(path .. '/.luarc.json')
								or vim.loop.fs_stat(path .. '/.luarc.jsonc')
							)
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
