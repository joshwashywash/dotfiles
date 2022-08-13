local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local ok, Job = pcall(require, 'plenary.job')

if ok then
  local source = {}

  source.new = function()
    return setmetatable({ cache = {} }, { __index = source })
  end

  source.complete = function(self, _, callback)
    local bufnr = vim.api.nvim_get_current_buf()
    if self.cache[bufnr] then
      callback({ items = self.cache[bufnr], isIncomplete = false })
    else
      Job
        :new({
          'gh',
          'issue',
          'list',
          '--limit',
          '1000',
          '--json',
          'body,number,title',
          on_exit = function(job)
            local result = job:result()
            local _ok, decoded =
              pcall(vim.json.decode, table.concat(result, ''))
            if _ok then
              local items = {}
              for _, item in ipairs(decoded) do
                table.insert(items, {
                  label = string.format('#%s', item.number),
                  documentation = {
                    kind = 'markdown',
                    value = string.format(
                      '# %s\n\n%s',
                      item.title,
                      string.gsub(item.body or '', '\r', '')
                    ),
                  },
                })
              end
              callback({ items = items, isIncomplete = false })
              self.cache[bufnr] = items
            else
              vim.notify('Unable to decode response.')
            end
          end,
        })
        :start()
    end
  end

  source.get_trigger_characters = function()
    return { '#' }
  end

  source.is_available = function()
    return vim.tbl_contains(
      { 'gitcommit', 'NeogitCommitMessage' },
      vim.bo.filetype
    )
  end

  cmp.register_source('gh_issues', source.new())
end

local offset = 4

cmp.setup({
  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol',
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ['<c-b>'] = cmp.mapping.scroll_docs(-offset),
    ['<c-e>'] = cmp.mapping.abort(),
    ['<c-f>'] = cmp.mapping.scroll_docs(offset),
    ['<c-space>'] = cmp.mapping.complete(),
    ['<cr>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'gh_issues' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
  }, { { name = 'buffer' } }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
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
