for xpcall, value in pairs(t) do
end
return {
	'hrsh7th/nvim-cmp',
	config = function(_, opts)
		local cmp = require('cmp')
		local luasnip = require('luasnip')

		local i = function()
			if cmp.visible() then
				if cmp.get_selected_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
				end
			else
				cmp.complete()
				cmp.select_next_item()
			end
		end

		-- when the docs for a completion are longer than the window
		cmp.setup({
			formatting = {
				format = require('lspkind').cmp_format({
					before = require('tailwindcss-colorizer-cmp').formatter,
					mode = 'symbol',
				}),
			},
			mapping = cmp.mapping.preset.insert({
				['<c-b>'] = cmp.mapping.scroll_docs(-opts.scroll_docs_offset),
				['<c-f>'] = cmp.mapping.scroll_docs(opts.scroll_docs_offset),
				['<c-h>'] = cmp.mapping(function()
					if cmp.visible() then
						if cmp.get_selected_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
						end
					else
						cmp.complete()
						cmp.select_next_item()
					end
				end),
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
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.kind,
				},
			},
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			}, { { name = 'buffer' } }),
			window = {
				completion = opts.win_options,
				documentation = opts.win_options,
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
		scroll_docs_offset = 4,
		has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0
				and vim.api
						.nvim_buf_get_lines(0, line - 1, line, true)[1]
						:sub(col, col)
						:match('%s')
					== nil
		end,
		win_options = {
			border = 'rounded',
		},
	},
}
