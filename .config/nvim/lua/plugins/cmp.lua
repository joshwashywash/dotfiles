return {
	'hrsh7th/nvim-cmp',
	config = function(_, opts)
		local cmp = require('cmp')
		local luasnip = require('luasnip')
		local defaults = require('cmp.config.default')()

		local window = cmp.config.window.bordered({
			winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Selection,Search:None',
		})

		-- when the docs for a completion are longer than the window
		local scroll_docs_offset = 4
		cmp.setup({
			formatting = {
				format = require('lspkind').cmp_format({
					before = require('tailwindcss-colorizer-cmp').formatter,
					mode = 'symbol',
				}),
			},
			mapping = cmp.mapping.preset.insert({
				['<c-b>'] = cmp.mapping.scroll_docs(-scroll_docs_offset),
				['<c-f>'] = cmp.mapping.scroll_docs(scroll_docs_offset),
				['<c-h>'] = cmp.mapping.complete(),
				['<cr>'] = cmp.mapping({
					c = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					i = function(fallback)
						if cmp.get_selected_entry() then
							cmp.confirm({
								behavior = cmp.ConfirmBehavior.Replace,
								select = false,
							})
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
				}),
				['<c-e>'] = cmp.mapping(function(fallback)
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif opts.has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<c-y>'] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					elseif opts.has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { 'i', 's' }),
			}),
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sorting = defaults.sorting,
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			}, { { name = 'buffer' } }),
			window = {
				completion = window,
				documentation = window,
			},
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' },
			}, {
				{ name = 'cmdline' },
			}),
		})

		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
	end,
	dependencies = {
		{
			'L3MON4D3/LuaSnip',
			build = 'make install_jsregexp',
			dependencies = {
				'rafamadriz/friendly-snippets',
				config = function()
					require('luasnip.loaders.from_vscode').lazy_load()
				end,
			},
		},
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-path',
		'onsails/lspkind-nvim',
		'saadparwaiz1/cmp_luasnip',
		{ 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },
		{
			'roobert/tailwindcss-colorizer-cmp.nvim',
			opts = {
				color_square_width = 6,
			},
		},
	},
	event = {
		'CmdlineEnter',
		'InsertEnter',
	},
	opts = {
		has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0
				and vim.api
						.nvim_buf_get_lines(0, line - 1, line, true)[1]
						:sub(col, col)
						:match('%s')
					== nil
		end,
	},
}

