return {
	'williamboman/mason.nvim',
	build = ':MasonUpdate',
	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('LspConfig', {}),
			callback = function(event)
				vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				local opts = { buffer = event.buf }

				vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<leader>lf', function()
					vim.lsp.buf.format({ async = true })
				end, opts)
				vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'gl', vim.lsp.buf.code_action, opts)
				vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, opts)
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

		require('mason-lspconfig').setup()

		require('mason-lspconfig').setup_handlers({
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
