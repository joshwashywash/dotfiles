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
			highlight = {
				additional_vim_regex_highlighting = false,
				enable = true,
			},
		})
	end,
}
