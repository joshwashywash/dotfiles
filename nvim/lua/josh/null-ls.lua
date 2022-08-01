local null_ls = require('null-ls')

--- null-ls does not support multi offset_encodings. fix this if/when it does
local notify = vim.notify
vim.notify = function(msg, ...)
  if not msg:match('warning: multiple different client offset_encodings') then
    notify(msg, ...)
  end
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.php,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.phpcsfixer.with({
      extra_filetypes = { 'tpl' },
    }),
    null_ls.builtins.formatting.prettier.with({
      extra_filetypes = { 'svelte', 'toml' },
    }),
    null_ls.builtins.formatting.stylua,
  },
})
