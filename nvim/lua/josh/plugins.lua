local ensure_installed = require('josh.langservers.ensure_installed')

local packer = require('packer')

-- local packer_bootstrap = false

-- local fn = vim.fn

-- local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   packer_bootstrap = fn.system({
--     'git',
--     'clone',
--     '--depth',
--     '1',
--     'https://github.com/wbthomason/packer.nvim',
--     install_path,
--   })
-- end

local plugins = {
  { 'wbthomason/packer.nvim' },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
    requires = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('josh.toggleterm')
    end,
  },
  {
    'akinsho/bufferline.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
    },
    config = function()
      require('josh.bufferline')
    end,
  },
  {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('josh.nvim-tree')
    end,
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('josh.treesitter')
    end,
    run = ':TSUpdate',
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        hint_enable = false,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('josh.lsp')
    end,
  },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        automatic_installation = true,
        ensure_installed = ensure_installed,
      })
    end,
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('josh.cmp')
    end,
  },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'L3MON4D3/LuaSnip' },
  {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('josh.telescope')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
    },
    config = function()
      require('josh.lualine')
    end,
  },
  { 'onsails/lspkind-nvim' },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  { 'folke/lsp-colors.nvim' },
  {
    'folke/trouble.nvim',
    config = function()
      require('josh.trouble')
    end,
    requires = 'kyazdani42/nvim-web-devicons',
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('josh.null-ls')
    end,
    requires = { 'nvim-lua/plenary.nvim' },
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  { 'b0o/schemastore.nvim' },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({ easing_function = 'sine' })
    end,
  },
  {
    'folke/which-key.nvim',
    config = function()
      require('josh.which-key')
    end,
  },
  {
    'catppuccin/nvim',
    as = 'catppuccin',
  },
  { 'RRethy/vim-illuminate' },
  {
    'lewis6991/impatient.nvim',
  },
  {
    'famiu/bufdelete.nvim',
  },
  {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup()
    end,
  },
  {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      require('rose-pine').setup({ dark_variant = 'moon' })
      vim.cmd('colorscheme rose-pine')
    end,
  },
  { 'machakann/vim-sandwich' },
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown' },
    run = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
  },
}

return packer.startup({
  function()
    for _, plugin in ipairs(plugins) do
      packer.use(plugin)
    end
    -- if packer_bootstrap then
    --   packer.sync()
    -- end
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end,
    },
  },
})
