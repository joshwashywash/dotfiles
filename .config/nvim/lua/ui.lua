-- diagnostic
vim.diagnostic.config({
	float = {
		border = 'rounded',
	},
	severity_sort = true,
	update_in_insert = true,
	virtual_text = false,
})

-- add a rounded border to the lsp floating window. taken from the nvim lsp gh wiki
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, window_opts, ...)
	window_opts = window_opts or {}
	window_opts.border = window_opts.border or 'rounded'
	return orig_util_open_floating_preview(contents, syntax, window_opts, ...)
end
