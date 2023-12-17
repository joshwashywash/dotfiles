vim.g.mapleader = ' '

-- MAPS
vim.keymap.set('n', '<s-down>', '<c-w>j', { desc = 'go to lower window' })
vim.keymap.set('n', '<s-left>', '<c-w>h', { desc = 'go to left window' })
vim.keymap.set('n', '<s-right>', '<c-w>l', { desc = 'go to right window' })
vim.keymap.set('n', '<s-up>', '<c-w>k', { desc = 'go to upper window' })

-- bufremove
vim.keymap.set('n', '<leader>bq', '<cmd>lua MiniBufremove.delete()<cr>', { desc = 'quit' })
vim.keymap.set('n', '<leader>bw', '<cmd>lua MiniBufremove.wipeout()<cr>', { desc = 'wipeout' })

-- files
vim.keymap.set('n', '<leader>f', '<cmd>lua MiniFiles.open()<cr>', { desc = 'open file explorer' })

-- pick
vim.keymap.set('n', '<leader>pb', '<cmd>Pick buffers<cr>', { desc = 'buffers' })
vim.keymap.set('n', '<leader>pc', '<cmd>Pick cli<cr>', { desc = 'cli' })
vim.keymap.set('n', '<leader>pf', '<cmd>Pick files<cr>', { desc = 'files' })
vim.keymap.set('n', '<leader>pg', '<cmd>Pick grep_live<cr>', { desc = 'grep_live' })
vim.keymap.set('n', '<leader>ph', '<cmd>Pick help<cr>', { desc = 'help' })
vim.keymap.set('n', '<leader>pr', '<cmd>Pick resume<cr>', { desc = 'resume' })

-- OPTS
vim.opt.fillchars = { eob = ' ' }
vim.opt.incsearch = true
vim.opt.shiftwidth = 2
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.signcolumn = 'yes'
vim.opt.showmode = false

-- UI
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
