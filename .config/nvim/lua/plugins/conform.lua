return {
	'stevearc/conform.nvim',
	cmd = { 'ConformInfo' },
	event = { 'BufWritePre' },
	opts = {
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		formatters_by_ft = {
			javascript = { { 'prettierd', 'prettier' } },
			lua = { 'stylua' },
			markdown = { { 'prettierd', 'prettier' } },
			svelte = { { 'prettierd', 'prettier' } },
			typescript = { { 'prettierd', 'prettier' } },
		},
	},
}
