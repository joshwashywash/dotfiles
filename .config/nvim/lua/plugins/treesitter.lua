return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function()
		require('nvim-treesitter.configs').setup({
			ensure_installed = {
				'astro',
				'css',
				'dart',
				'html',
				'javascript',
				'jsdoc',
				'json',
				'lua',
				'markdown',
				'markdown_inline',
				'svelte',
				'typescript',
				'vim',
				'vimdoc',
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
			highlight = {
				additional_vim_regex_highlighting = false,
				enable = true,
			},
		})
	end,
}
