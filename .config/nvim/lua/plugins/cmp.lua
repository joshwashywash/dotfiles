return {
  'hrsh7th/nvim-cmp',
  config = function()
    local cmp = require('cmp')
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local luasnip = require('luasnip')

    require('luasnip.loaders.from_vscode').lazy_load()

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
        and vim.api
            .nvim_buf_get_lines(0, line - 1, line, true)[1]
            :sub(col, col)
            :match('%s')
          == nil
    end

    local window = cmp.config.window.bordered({
      winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Selection,Search:None',
    })

    -- when the docs for a completion are longer than the window
    local scroll_docs_offset = 4

    cmp.setup({
      formatting = {
        format = require('lspkind').cmp_format({
          before = require('tailwindcss-colorizer-cmp').formatter,
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ['<c-b>'] = cmp.mapping.scroll_docs(-scroll_docs_offset),
        ['<c-f>'] = cmp.mapping.scroll_docs(scroll_docs_offset),
        ['<c-space>'] = cmp.mapping(function()
          -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.confirm()
            end
          else
            cmp.mapping.complete()()
          end
        end, { 'i', 's', 'c' }),
        ['<c-e>'] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's', 'c' }),
        ['<c-y>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's', 'c' }),
      }),
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
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

    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
  dependencies = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'onsails/lspkind-nvim',
    'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',
    'windwp/nvim-autopairs',
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
}
