return {
  'neovim/nvim-lspconfig',
  config = function(_, opts)
    local mason_config = require('mason-lspconfig')

    mason_config.setup({
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
    function vim.lsp.util.open_floating_preview(
      contents,
      syntax,
      window_opts,
      ...
    )
      window_opts = window_opts or {}
      window_opts.border = window_opts.border or 'rounded'
      return orig_util_open_floating_preview(contents, syntax, window_opts, ...)
    end

    vim.diagnostic.config(opts.diagnostics)

    -- some servers aren't on mason so use this to add them
    local extra_servers = { 'dartls' }
    local servers = vim.list_extend(
      mason_config.get_installed_servers(),
      extra_servers,
      1,
      #extra_servers
    )

    local capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )

    for _, server in ipairs(servers) do
      local server_opts = {
        capabilities = capabilities,
        on_attach = function()
          local keymaps = {
            { '<leader>lD', vim.lsp.buf.declaration, 'declaration' },
            { '<leader>lH', vim.lsp.buf.signature_help, 'signature help' },
            { '<leader>lR', vim.lsp.buf.rename, 'rename' },
            {
              '<leader>lW',
              vim.lsp.buf.remove_workspace_folder,
              'remove workspace folder',
            },
            { '<leader>ld', vim.lsp.buf.definition, 'definition' },
            { '<leader>lf', vim.lsp.buf.format, 'format' },
            { '<leader>lh', vim.lsp.buf.hover, 'hover' },
            { '<leader>li', vim.lsp.buf.implementation, 'implementation' },
            {
              '<leader>ll',
              function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folder))
              end,
              'list workspace folder',
            },
            { '<leader>lr', vim.lsp.buf.references, 'references' },
            { '<leader>lt', vim.lsp.buf.type_definition, 'type definitions' },
            {
              '<leader>lw',
              vim.lsp.buf.add_workspace_folder,
              'add workspace folder',
            },
          }

          for _, keymap in ipairs(keymaps) do
            local l, r, desc = unpack(keymap)
            vim.keymap.set('n', l, r, { desc = desc })
          end
        end,
      }

      local _ok, extra_opts =
        pcall(require, string.format('langservers.%s', server))

      if _ok then
        server_opts = vim.tbl_extend('keep', server_opts, extra_opts)
      end

      lspconfig[server].setup(server_opts)
    end
  end,
  dependencies = {
    'b0o/schemastore.nvim',
    'folke/lsp-colors.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'j-hui/fidget.nvim',
    'williamboman/mason-lspconfig.nvim',
    { 'williamboman/mason.nvim', config = true },
  },
  event = 'BufReadPre',
  opts = {
    diagnostics = {
      float = {
        border = 'rounded',
      },
      severity_sort = true,
      update_in_insert = true,
      virtual_text = false,
    },
  },
}