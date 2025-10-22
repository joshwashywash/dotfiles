MiniDeps.later(function()
	MiniDeps.add({
		checkout = 'main',
		hooks = {
			post_checkout = function()
				vim.cmd('TSUpdate')
			end,
		},
		source = 'nvim-treesitter/nvim-treesitter',
	})

	require('nvim-treesitter.configs').setup({
		ensure_installed = {
			'astro',
			'css',
			'dart',
			'go',
			'html',
			'javascript',
			'jsdoc',
			'json',
			'lua',
			'query',
			'markdown',
			'markdown_inline',
			'svelte',
			'tsx',
			'typescript',
			'vim',
			'vimdoc',
			'wgsl',
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<leader>n',
				node_incremental = 'n',
				node_decremental = 'N',
				scope_incremental = false,
			},
		},
		indent = {
			enable = true,
		},
		highlight = {
			additional_vim_regex_highlighting = false,
			enable = true,
		},
	})
end)
