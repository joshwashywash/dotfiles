MiniDeps.later(function()
	require('mini.completion').setup({
		lsp_completion = {
			auto_setup = false,
			source_func = 'omnifunc',
		},
	})

	local on_attach = function(args)
		vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
	end

	vim.api.nvim_create_autocmd('LspAttach', {
		callback = on_attach,
	})

	local capabilities = MiniCompletion.get_lsp_capabilities()

	vim.lsp.config('*', {
		capabilities = capabilities,
	})
end)
