vim.api.nvim_create_user_command('FormatDisable', function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = 'Disable autoformat-on-save',
	bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = 'Enable autoformat-on-save',
})

--- @param bufnr integer
--- @param ... string
--- @return string
local function first(bufnr, ...)
	local conform = require('conform')
	for i = 1, select('#', ...) do
		local formatter = select(i, ...)
		if conform.get_formatter_info(formatter, bufnr).available then
			return formatter
		end
	end
	return select(1, ...)
end

local prettier = {
	'prettierd',
	'prettier',
	stop_after_first = true,
}

MiniDeps.later(function()
	MiniDeps.add('stevearc/conform.nvim')

	local conform = require('conform')

	conform.setup({
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return {
				lsp_format = 'fallback',
				timeout_ms = 500,
			}
		end,
		formatters_by_ft = {
			astro = {
				'prettier',
			},
			gleam = {
				'gleam',
			},
			javascript = prettier,
			lua = {
				'stylua',
			},
			markdown = function(bufnr)
				return {
					first(bufnr, 'prettierd', 'prettier'),
					'injected',
				}
			end,
			svelte = prettier,
			typescript = prettier,
		},
	})
end)
