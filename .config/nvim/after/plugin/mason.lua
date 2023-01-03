require('mason').setup()
require('mason-lspconfig').setup({
  automatic_installation = true,
  ensure_installed = {
    'emmet_ls',
    'html',
    'intelephense',
    'jsonls',
    'sumneko_lua',
    'svelte',
    'tailwindcss',
    'tsserver',
  },
})
