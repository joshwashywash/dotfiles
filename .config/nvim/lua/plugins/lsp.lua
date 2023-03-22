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
        'lua_ls',
        'svelte',
        'tailwindcss',
        'tsserver',
      },
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )

    mason_config.setup_handlers({
      function(name)
        local _opts = { capabilities = capabilities }

        local ok, extra_opts =
          pcall(require, string.format('langservers.%s', name))

        require('lspconfig')[name].setup(
          vim.tbl_extend('keep', _opts, ok and extra_opts or {})
        )
      end,
    })

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
    local diagnostic_keymaps = {
      { '[d', vim.diagnostic.goto_prev, 'previous' },
      { ']d', vim.diagnostic.goto_next, 'next' },
    }

    for _, keymap in pairs(diagnostic_keymaps) do
      local l, r, desc = unpack(keymap)
      vim.keymap.set('n', l, r, {
        noremap = true,
        silent = true,
        desc = 'go to ' .. desc .. ' diagnostic',
      })
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('LspConfig', {}),
      callback = function(event)
        vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local keymaps = {
          { '<leader>lD', vim.lsp.buf.declaration, 'declaration' },
          { '<leader>lK', vim.lsp.buf.signature_help, 'signature help' },
          { '<leader>lR', vim.lsp.buf.references, 'references' },
          {
            '<leader>lW',
            vim.lsp.buf.remove_workspace_folder,
            'remove workspace folder',
          },
          { '<leader>lc', vim.lsp.buf.code_action, 'code action' },
          { '<leader>ld', vim.lsp.buf.definition, 'definition' },
          {
            '<leader>lf',
            function()
              vim.lsp.buf.format({ async = true })
            end,
            'format',
          },
          { '<leader>li', vim.lsp.buf.implementation, 'implementation' },
          {
            '<leader>ll',
            function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folder))
            end,
            'list workspace folder',
          },
          { '<leader>lr', vim.lsp.buf.rename, 'rename' },
          { '<leader>lt', vim.lsp.buf.type_definition, 'type definitions' },
          {
            '<leader>lw',
            vim.lsp.buf.add_workspace_folder,
            'add workspace folder',
          },
          { '<leader>lx', vim.diagnostic.open_float, 'show line diagnostic' },
          { 'K', vim.lsp.buf.hover, 'hover' },
        }

        for _, keymap in ipairs(keymaps) do
          local l, r, desc = unpack(keymap)

          vim.keymap.set('n', l, r, {
            buffer = event.buf,
            desc = desc,
            noremap = true,
            silent = true,
          })
        end
      end,
    })
  end,
  dependencies = {
    'b0o/schemastore.nvim',
    'folke/lsp-colors.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'j-hui/fidget.nvim',
    'ray-x/lsp_signature.nvim',
    'williamboman/mason-lspconfig.nvim',
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