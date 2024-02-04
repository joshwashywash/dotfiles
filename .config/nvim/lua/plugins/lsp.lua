return {
	'williamboman/mason.nvim',
	build = ':MasonUpdate',
	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('LspConfig', {}),
			callback = function(event)
				vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = event.buf })
				end

				map('n', '<c-k>', vim.lsp.buf.signature_help, 'signature help')
				map('n', '<leader>lR', '<cmd>LspRestart<cr>', 'restart lsps')
				map('n', '<leader>lf', function()
					vim.lsp.buf.format({ async = true })
				end, 'format')
				map('n', '<leader>lr', vim.lsp.buf.rename, 'rename')
				map('n', 'K', vim.lsp.buf.hover, 'hover')
				map('n', 'gD', vim.lsp.buf.declaration, 'go to declaration')
				map('n', 'gd', vim.lsp.buf.definition, 'go to definition')
				map('n', 'gl', vim.lsp.buf.implementation, 'go to implementation')
				map({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, 'code action')
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

		require('mason-lspconfig').setup({
			handlers = {
				['jsonls'] = function()
					require('lspconfig').jsonls.setup({
						settings = {
							json = {
								schemas = require('schemastore').json.schemas(),
								validate = { enable = true },
							},
						},
					})
				end,
				['lua_ls'] = function()
					require('lspconfig').lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { 'vim' },
								},
							},
						},
					})
				end,
				function(server_name)
					require('lspconfig')[server_name].setup({})
				end,
			},
		})
	end,
	dependencies = {
		{ 'b0o/schemastore.nvim' },
		{ 'neovim/nvim-lspconfig' },
		{ 'williamboman/mason-lspconfig.nvim' },
		{
			'onsails/lspkind.nvim',
			config = function()
				require('lspkind').init({ mode = 'symbol' })
			end,
		},
	},
}
