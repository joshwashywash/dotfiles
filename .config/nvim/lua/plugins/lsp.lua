return {
	'williamboman/mason.nvim',
	build = ':MasonUpdate',
	config = function()
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
