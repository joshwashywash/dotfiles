-- disable netrw for nvim tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opts = {
	background = 'dark',
	clipboard = 'unnamedplus',
	-- cmdheight = 0,
	completeopt = { 'menu', 'menuone', 'noselect' },
	fillchars = { eob = ' ' },
	guifont = 'monospace:h16',
	hidden = true,
	hlsearch = false,
	ignorecase = true,
	incsearch = true,
	mouse = 'a',
	number = false,
	pumheight = 4,
	relativenumber = false,
	scrolloff = 4,
	shiftwidth = 2,
	showmode = false,
	showtabline = 0, -- tabs are shown in lualine
	signcolumn = 'yes',
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	tabstop = 2,
	termguicolors = true,
	timeoutlen = 300,
	updatetime = 250,
	wrap = false,
	writebackup = false,
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end
