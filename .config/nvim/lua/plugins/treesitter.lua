return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function()
		require('nvim-treesitter.configs').setup({
			autotag = { enable = true },
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
				enable = true, -- false will disable the whole extension
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<c-j>',
					node_decremental = '<c-m>',
					node_incremental = '<c-j>',
					scope_incremental = '<c-s>',
				},
			},
			matchup = {
				enable = true,
			},
			textobjects = {
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						[']k'] = '@class.outer',
						[']f'] = '@function.outer',
					},
					goto_next_end = {
						[']K'] = '@class.outer',
						[']F'] = '@function.outer',
					},
					goto_previous_start = {
						['[k'] = '@class.outer',
						['[f'] = '@function.outer',
					},
					goto_previous_end = {
						['[K'] = '@class.outer',
						['[F'] = '@function.outer',
					},
				},
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						['aa'] = '@parameter.outer',
						['ac'] = '@class.outer',
						['af'] = '@function.outer',
						['ia'] = '@parameter.inner',
						['ic'] = '@class.inner',
						['if'] = '@function.inner',
						['as'] = {
							query = '@scope',
							query_group = 'locals',
							desc = 'Select language scope',
						},
					},
				},
				swap = {
					enable = true,
					-- <c-n> and <c-p> are aliases for up and down in normal mode
					swap_next = {
						['<c-n>'] = '@parameter.inner',
					},
					swap_previous = {
						['<c-p>'] = '@parameter.inner',
					},
				},
			},
		})
	end,
	dependencies = {
		'andymass/vim-matchup',
		'nvim-treesitter/nvim-treesitter-textobjects',
		'windwp/nvim-ts-autotag',
	},
	event = 'BufReadPost',
}
