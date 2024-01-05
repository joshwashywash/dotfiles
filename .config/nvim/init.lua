vim.g.mapleader = ' '

vim.keymap.set('n', '<s-down>', '<c-w>j', { desc = 'go to lower window' })
vim.keymap.set('n', '<s-left>', '<c-w>h', { desc = 'go to left window' })
vim.keymap.set('n', '<s-right>', '<c-w>l', { desc = 'go to right window' })
vim.keymap.set('n', '<s-up>', '<c-w>k', { desc = 'go to upper window' })

local nmap_leader = function(suffix, rhs, desc)
	vim.keymap.set('n', '<leader>' .. suffix, rhs, { desc = desc })
end

-- bufremove
nmap_leader('bq', '<cmd>lua MiniBufremove.delete()<cr>', 'quit')
nmap_leader('bw', '<cmd>lua MiniBufremove.wipeout()<cr>', 'wipeout')

-- files
nmap_leader('f', '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>', 'open files')

-- pick
nmap_leader('eC', '<cmd>Pick cli<cr>', 'cli')
nmap_leader('eF', '<cmd>Pick files<cr>', 'files')
nmap_leader('eG', '<cmd>Pick hl_groups<cr>', 'hl groups')
nmap_leader('eH', '<cmd>Pick help<cr>', 'help')
nmap_leader('eR', '<cmd>Pick registers<cr>', 'registers')
nmap_leader('eb', '<cmd>Pick buffers<cr>', 'buffers')
nmap_leader('ec', '<cmd>Pick commands<cr>', 'comands')
nmap_leader('ed', "<cmd>Pick diagnostic scope='current'<cr>", 'diagnostic')
nmap_leader('ee', '<cmd>Pick explorer<cr>', 'explorer')
nmap_leader('ef', '<cmd>Pick oldfiles<cr>', 'recent files')
nmap_leader('eg', '<cmd>Pick grep_live<cr>', 'grep_live')
nmap_leader('eh', '<cmd>Pick history<cr>', 'history')
nmap_leader('ek', '<cmd>Pick keymaps<cr>', 'keymaps')
nmap_leader('em', '<cmd>Pick marks<cr>', 'marks')
nmap_leader('eo', '<cmd>Pick options<cr>', 'options')
nmap_leader('ep', '<cmd>Pick hipatterns<cr>', 'hi patterns')
nmap_leader('er', '<cmd>Pick resume<cr>', 'resume')
nmap_leader('et', '<cmd>Pick treesitter<cr>', 'treesitter')
nmap_leader('ev', '<cmd>Pick visit_paths<cr>', 'visits')

vim.opt.cmdheight = 0
vim.opt.fillchars = { eob = ' ' }
vim.opt.incsearch = true
vim.opt.pumheight = 10
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.splitbelow = true
vim.opt.statusline = '%f %= %m'
vim.opt.tabstop = 2

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
