return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function()
		require('nvim-treesitter.configs').setup({
			auto_install = true,
			autotag = {
				enable = true,
			},
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
			ignore_install = {},
			highlight = {
				enable = true, -- false will disable the whole extension
			},
			matchup = {
				enable = true,
			},
			modules = {},
			sync_install = false,
			textobjects = {
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						[']k'] = '@class.outer',
						[']f'] = '@function.outer',
						[']i'] = '@conditional.outer',
						[']l'] = '@loop.outer',
						[']c'] = '@comment.outer',
						[']r'] = '@return.outer',
					},
					goto_next_end = {
						[']K'] = '@class.outer',
						[']F'] = '@function.outer',
						[']I'] = '@conditional.outer',
						[']L'] = '@loop.outer',
						[']C'] = '@comment.outer',
						[']R'] = '@return.outer',
					},
					goto_previous_start = {
						['[k'] = '@class.outer',
						['[f'] = '@function.outer',
						['[i'] = '@conditional.outer',
						['[l'] = '@loop.outer',
						['[c'] = '@comment.outer',
						['[r'] = '@return.outer',
					},
					goto_previous_end = {
						['[K'] = '@class.outer',
						['[F'] = '@function.outer',
						['[I'] = '@conditional.outer',
						['[L'] = '@loop.outer',
						['[C'] = '@comment.outer',
						['[R'] = '@return.outer',
					},
				},
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						['a='] = '@assignment.outer',
						['i='] = '@assignment.inner',
						['l='] = '@assignment.lhs',
						['r='] = '@assignment.rhs',
						['aa'] = '@parameter.outer',
						['ia'] = '@parameter.inner',
						['ac'] = '@class.outer',
						['ic'] = '@class.inner',
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['ai'] = '@conditional.outer',
						['ii'] = '@conditional.inner',
						['al'] = '@loop.outer',
						['il'] = '@loop.inner',
						['a/'] = '@comment.outer',
						['i/'] = '@comment.inner',
						['ar'] = '@return.outer',
						['ir'] = '@return.inner',
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
						-- ['<c-n>'] = '@call.inner',
					},
					swap_previous = {
						['<c-p>'] = '@parameter.inner',
						-- ['<c-p>'] = '@call.inner',
					},
				},
			},
		})
	end,
	cmd = { 'TSUpdateSync' },
	dependencies = {
		'andymass/vim-matchup',
		'nvim-treesitter/nvim-treesitter-textobjects',
		'windwp/nvim-ts-autotag',
	},
	event = { 'BufReadPost', 'BufNewFile' },
}
