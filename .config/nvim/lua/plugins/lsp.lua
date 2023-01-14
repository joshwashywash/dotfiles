return {
  'neovim/nvim-lspconfig',
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      automatic_installation = true,
      ensure_installed = {
        'emmet_ls',
        'html',
        'jsonls',
        'sumneko_lua',
        'svelte',
        'tailwindcss',
        'tsserver',
      },
    })

    local lspconfig = require('lspconfig')

    -- add a rounded border to the lsp floating window. taken from the nvim lsp gh wiki
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or 'rounded'
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    vim.diagnostic.config({
      float = {
        border = 'rounded',
      },
      severity_sort = true,
      update_in_insert = true,
      virtual_text = false,
    })

    -- some servers aren't on mason so use this to add them
    local extra_servers = { 'dartls' }
    local servers = vim.list_extend(
      require('mason-lspconfig').get_installed_servers(),
      extra_servers,
      1,
      #extra_servers
    )

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local wk = require('which-key')

    for _, server in ipairs(servers) do
      local opts = {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          wk.register({
            l = {
              D = { vim.lsp.buf.declaration, 'declaration' },
              H = { vim.lsp.buf.signture_help, 'signature help' },
              R = { vim.lsp.buf.rename, 'rename' },
              W = {
                vim.lsp.buf.remove_workspace_folder,
                'remove workspace folder',
              },
              c = { vim.lsp.buf.code_action, 'code action' },
              d = { vim.lsp.buf.definition, 'definition' },
              f = { vim.lsp.buf.format, 'format' },
              h = { vim.lsp.buf.hover, 'hover' },
              i = { vim.lsp.buf.implementation, 'implementation' },
              l = {
                function()
                  print(vim.inspect(vim.lsp.buf.list_workspace_folder))
                end,
                'list workspace folder',
              },
              r = { vim.lsp.buf.references, 'references' },
              t = { vim.lsp.buf.type_definition, 'type definitions' },
              w = { vim.lsp.buf.add_workspace_folder, 'add workspace folder' },
              'lsp',
            },
          }, { buffer = bufnr, prefix = '<leader>' })
        end,
      }

      local _ok, extra_opts =
        pcall(require, string.format('langservers.%s', server))

      if _ok then
        opts = vim.tbl_extend('keep', opts, extra_opts)
      end

      lspconfig[server].setup(opts)
    end
  end,
  dependencies = {
    'b0o/schemastore.nvim',
    'folke/lsp-colors.nvim',
    'folke/neodev.nvim',
    'j-hui/fidget.nvim',
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',
  },
}
