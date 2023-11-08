return {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	opts = {
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		formatters_by_ft = {
			javascript = { { 'prettierd', 'prettier' } },
			lua = { 'stylua' },
			markdown = { { 'prettierd', 'prettier' } },
			typescript = { { 'prettierd', 'prettier' } },
		},
	},
}
