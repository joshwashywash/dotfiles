vim.g.mapleader = ' '

vim.keymap.set('n', '<s-down>', '<c-w>j', { desc = 'go to lower window' })
vim.keymap.set('n', '<s-left>', '<c-w>h', { desc = 'go to left window' })
vim.keymap.set('n', '<s-right>', '<c-w>l', { desc = 'go to right window' })
vim.keymap.set('n', '<s-up>', '<c-w>k', { desc = 'go to upper window' })

-- bufremove
vim.keymap.set('n', '<leader>bq', '<cmd>lua MiniBufremove.delete()<cr>', { desc = 'quit' })
vim.keymap.set('n', '<leader>bw', '<cmd>lua MiniBufremove.wipeout()<cr>', { desc = 'wipeout' })

-- files
vim.keymap.set('n', '<leader>f', '<cmd>lua MiniFiles.open()<cr>', { desc = 'open files' })

-- pick
vim.keymap.set('n', '<leader>pC', '<cmd>Pick cli<cr>', { desc = 'cli' })
vim.keymap.set('n', '<leader>pF', '<cmd>Pick oldfiles<cr>', { desc = 'recent files' })
vim.keymap.set('n', '<leader>pG', '<cmd>Pick hl_groups<cr>', { desc = 'hl groups' })
vim.keymap.set('n', '<leader>pH', '<cmd>Pick help<cr>', { desc = 'help' })
vim.keymap.set('n', '<leader>pR', '<cmd>Pick resume<cr>', { desc = 'resume' })
vim.keymap.set('n', '<leader>pb', '<cmd>Pick buffers<cr>', { desc = 'buffers' })
vim.keymap.set('n', '<leader>pc', '<cmd>Pick commands<cr>', { desc = 'comands' })
vim.keymap.set(
	'n',
	'<leader>pd',
	"<cmd>Pick diagnostic scope='current'<cr>",
	{ desc = 'diagnostic' }
)
vim.keymap.set('n', '<leader>pe', '<cmd>Pick explorer<cr>', { desc = 'explorer' })
vim.keymap.set('n', '<leader>pf', '<cmd>Pick files<cr>', { desc = 'files' })
vim.keymap.set('n', '<leader>pg', '<cmd>Pick grep_live<cr>', { desc = 'grep_live' })
vim.keymap.set('n', '<leader>ph', '<cmd>Pick history<cr>', { desc = 'history' })
vim.keymap.set('n', '<leader>pk', '<cmd>Pick keymaps<cr>', { desc = 'keymaps' })
vim.keymap.set('n', '<leader>pm', '<cmd>Pick marks<cr>', { desc = 'marks' })
vim.keymap.set('n', '<leader>po', '<cmd>Pick options<cr>', { desc = 'options' })
vim.keymap.set('n', '<leader>pp', '<cmd>Pick hipatterns<cr>', { desc = 'hi patterns' })
vim.keymap.set('n', '<leader>pr', '<cmd>Pick registers<cr>', { desc = 'registers' })
vim.keymap.set('n', '<leader>pt', '<cmd>Pick treesitter<cr>', { desc = 'treesitter' })
vim.keymap.set('n', '<leader>pv', '<cmd>Pick visit_paths<cr>', { desc = 'visits' })

vim.opt.cmdheight = 0
vim.opt.fillchars = { eob = ' ' }
vim.opt.incsearch = true
vim.opt.pumheight = 10
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.splitbelow = true
vim.opt.statusline = '%f %m %= %l:%c ♥'
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
