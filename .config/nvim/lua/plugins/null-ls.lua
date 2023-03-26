return {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    local null_ls = require('null-ls')

    local augroup =
      vim.api.nvim_create_augroup('LspFormatting', { clear = true })

    null_ls.setup({
      border = 'rounded',
      on_attach = function(client, bufnr)
        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                bufnr = bufnr,
                filter = function(_client)
                  return _client.name == 'null-ls'
                end,
              })
            end,
            group = augroup,
          })
        end
      end,
      sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.dart_format,
        null_ls.builtins.formatting.prettier.with({
          extra_filetypes = { 'astro', 'svelte', 'toml' },
        }),
        null_ls.builtins.formatting.stylua,
      },
    })
  end,
  dependencies = 'nvim-lua/plenary.nvim',
  event = { 'BufNewFile', 'BufReadPre' },
}
