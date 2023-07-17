return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('LspConfig', {}),
				callback = function(event)
					vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					local keymaps = {
						{ 'd', vim.lsp.buf.definition, 'definition' },
						{ 'D', vim.lsp.buf.declaration, 'declaration' },
						{ 't', vim.lsp.buf.type_definition, 'type definitions' },
					}

					for _, keymap in ipairs(keymaps) do
						local l, r, desc = unpack(keymap)

						vim.keymap.set('n', 'g' .. l, r, {
							buffer = event.buf,
							desc = desc,
							noremap = true,
							silent = true,
						})
					end

					local lsp_keymaps = {
						{ 'c', vim.lsp.buf.code_action, 'execute code action' },
						{ 'R', vim.lsp.buf.references, 'list references' },
						{
							's',
							function()
								print('restarting lsp')
								vim.cmd('LspRestart')
							end,
							'restart',
						},
						{
							'f',
							function()
								vim.lsp.buf.format({ async = true })
							end,
							'format buffer',
						},
						{ 'i', vim.lsp.buf.implementation, 'list implementations' },
						{ 'o', vim.lsp.buf.hover, 'hover' },
						{ 'r', vim.lsp.buf.rename, 'rename' },
						{ 's', vim.lsp.buf.signature_help, 'signature help' },
						{ 'x', vim.diagnostic.open_float, 'show line diagnostic' },
					}

					for _, keymap in ipairs(lsp_keymaps) do
						local l, r, desc = unpack(keymap)

						vim.keymap.set('n', '<leader>l' .. l, r, {
							buffer = event.buf,
							desc = desc,
							noremap = true,
							silent = true,
						})
					end
				end,
			})

			require('lspconfig.ui.windows').default_options.border = 'rounded'
		end,
		dependencies = {
			'b0o/schemastore.nvim',
		},
		event = 'BufReadPre',
	},
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			require('mason-lspconfig').setup({
				automatic_installation = true,
				ensure_installed = {
					'emmet_ls',
					'html',
					'jsonls',
					'lua_ls',
					'svelte',
					'tailwindcss',
					'tsserver',
				},
				handlers = {
					function(name)
						local _opts = { capabilities = capabilities }

						local ok, extra_opts =
							pcall(require, string.format('langservers.%s', name))

						require('lspconfig')[name].setup(
							vim.tbl_extend('keep', _opts, ok and extra_opts or {})
						)
					end,
				},
			})
		end,
		dependencies = 'hrsh7th/cmp-nvim-lsp',
		event = 'VeryLazy',
	},
	{ 'j-hui/fidget.nvim', opts = {}, event = 'VeryLazy' },
	{
		'ray-x/lsp_signature.nvim',
		opts = {
			doc_lines = 0,
			hint_enable = false,
			toggle_key = '<c-s>',
		},
		event = 'VeryLazy',
	},
}
