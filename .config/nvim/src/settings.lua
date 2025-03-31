vim.g.mapleader = ' '

vim.o.cmdheight = 0
vim.o.completeopt = 'fuzzy,menuone,noinsert,popup'
vim.o.fillchars = table.concat({
	'eob: ',
}, ',')
vim.o.pumheight = 4
vim.o.shiftwidth = 2
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statusline = '%f %= %m'
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.winborder = 'rounded'

vim.diagnostic.config({
	-- TODO if priority ever gets exposed through some api, remove this
	signs = {
		priority = 10,
	},
	underline = false,
})
