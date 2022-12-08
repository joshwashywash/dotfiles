local null_ls = require('null-ls')

local augroup = vim.api.nvim_create_augroup('LspFormatting', { clear = true })

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(client)
              return client.name == 'null-ls'
            end,
            timeout = 2000,
          })
        end,
        group = augroup,
      })
    end
  end,
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.dart_format,
    null_ls.builtins.formatting.prettier.with({
      extra_filetypes = { 'svelte', 'toml' },
    }),
    null_ls.builtins.formatting.stylua,
  },
})
