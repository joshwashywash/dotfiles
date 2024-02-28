vim.g.mapleader = ' '

vim.keymap.set('n', '<s-down>', '<c-w>j', { desc = 'go to lower window' })
vim.keymap.set('n', '<s-left>', '<c-w>h', { desc = 'go to left window' })
vim.keymap.set('n', '<s-right>', '<c-w>l', { desc = 'go to right window' })
vim.keymap.set('n', '<s-up>', '<c-w>k', { desc = 'go to upper window' })

---@param suffix string
---@param rhs string|function
---@param opts {desc?:string}
local nmap_leader = function(suffix, rhs, opts)
	vim.keymap.set('n', '<leader>' .. suffix, rhs, opts)
end

nmap_leader('bq', '<cmd>lua MiniBufremove.delete()<cr>', { desc = 'quit' })
nmap_leader('bw', '<cmd>lua MiniBufremove.wipeout()<cr>', { desc = 'wipeout' })

nmap_leader(
	'f',
	'<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>',
	{ desc = 'open files' }
)

--- @class Pick
--- @field cmd string
--- @field desc? string
--- @field keymap string

---@type Pick[]
local picks = {
	{
		cmd = 'cli',
		keymap = 'C',
	},
	{
		cmd = 'files',
		keymap = 'F',
	},
	{
		cmd = 'hl_groups',
		desc = 'hl groups',
		keymap = 'G',
	},
	{
		cmd = 'help',
		keymap = 'H',
	},
	{
		cmd = 'registers',
		keymap = 'R',
	},
	{
		cmd = 'buffers',
		keymap = 'b',
	},
	{
		cmd = 'commands',
		keymap = 'c',
	},
	{
		cmd = "diagnostic scope='current'",
		desc = 'diagnostic',
		keymap = 'd',
	},
	{
		cmd = 'explorer',
		keymap = 'e',
	},
	{
		cmd = 'oldfiles',
		desc = 'recent files',
		keymap = 'f',
	},
	{
		cmd = 'grep_live',
		desc = 'live grep',
		keymap = 'g',
	},
	{
		cmd = 'history',
		keymap = 'h',
	},
	{
		cmd = 'keymaps',
		keymap = 'k',
	},
	{
		cmd = 'marks',
		keymap = 'm',
	},
	{
		cmd = 'options',
		keymap = 'o',
	},
	{
		cmd = 'hipatterns',
		desc = 'hi patterns',
		keymap = 'p',
	},
	{
		cmd = 'resume',
		keymap = 'r',
	},
	{
		cmd = 'treesitter',
		keymap = 't',
	},
	{
		cmd = 'visit_paths',
		desc = 'visits',
		keymap = 'v',
	},
}

for _, pick in ipairs(picks) do
	nmap_leader('e' .. pick.keymap, function()
		vim.cmd('Pick ' .. pick.cmd)
	end, { desc = pick.desc or pick.cmd })
end

local opts = {
	cmdheight = 0,
	fillchars = { eob = ' ' },
	incsearch = true,
	pumheight = 10,
	shiftwidth = 2,
	showmode = false,
	signcolumn = 'yes',
	splitbelow = true,
	statusline = '%f %= %m',
	tabstop = 2,
}

for key, value in pairs(opts) do
	vim.opt[key] = value
end

vim.diagnostic.config({
	virtual_text = false,
})

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')
