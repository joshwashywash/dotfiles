local lspconfig = require('lspconfig')

vim.diagnostic.config({
  float = {
    border = 'rounded',
  },
  severity_sort = true,
  update_in_insert = true,
  virtual_text = false,
})

local keymaps = {
  K = vim.lsp.buf.hover,
  Rn = vim.lsp.buf.rename,
  gC = vim.lsp.buf.code_action,
  gD = vim.lsp.buf.declaration,
  gK = vim.lsp.buf.signture_help,
  gd = vim.lsp.buf.definition,
  gr = vim.lsp.buf.references,
  gy = vim.lsp.buf.type_definition,
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local function on_attach(client, bufnr)
  for k, v in pairs(keymaps) do
    vim.keymap.set('n', k, v, { buffer = bufnr })
  end
end

local servers = vim.list_extend(
  require('mason-lspconfig').get_installed_servers(),
  { 'ccls' }
)

for _, server in ipairs(servers) do
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach,
  }

  local _ok, extra_opts =
    pcall(require, string.format('josh.langservers.%s', server))

  if _ok then
    opts = vim.tbl_extend('keep', opts, extra_opts)
  end

  lspconfig[server].setup(opts)
end
