vim.g.mapleader = ' '
vim.o.cmdheight = 0
vim.o.fillchars = table.concat({
	'eob: ',
}, ',')
vim.o.incsearch = true
vim.o.pumheight = 4
vim.o.shiftwidth = 2
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statusline = '%f %= %m'
vim.o.tabstop = 2
vim.o.termguicolors = true

local ui = {
	border = 'rounded',
}

vim.diagnostic.config({
	float = ui,
	-- TODO if priority ever gets exposed through some api, remove this
	signs = {
		priority = 10,
	},
	underline = false,
	virtual_text = false,
})

local singleBorderConfig = vim.lsp.with(vim.lsp.handlers.hover, ui)

local handlers = {
	'hover',
	'signatureHelp',
}

for _, handler in ipairs(handlers) do
	vim.lsp.handlers['textDocument/' .. handler] = singleBorderConfig
end
