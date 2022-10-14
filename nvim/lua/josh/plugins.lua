local packer = require('packer')

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')
    .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

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
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({ default = true })
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
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
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
    end,
  },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { 'hrsh7th/cmp-path' },
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
    config = function()
      require('josh.lualine')
    end,
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
    },
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
      require('trouble').setup({
        action_keys = {
          next = 'k',
          open_split = { 's' },
          open_vsplit = { 'v' },
          previous = 'j',
        },
        height = 6,
      })
    end,
    requires = 'kyazdani42/nvim-web-devicons',
  },
  {
    'folke/todo-comments.nvim',
    config = function()
      require('todo-comments').setup()
    end,
    requires = 'nvim-lua/plenary.nvim',
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
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({ delay = 1000 })
    end,
  },
  { 'lewis6991/impatient.nvim' },
  { 'famiu/bufdelete.nvim' },
  {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup()
    end,
  },
  { 'savq/melange', as = 'melange' },
  {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      vim.g.catppuccin_flavour = 'mocha'
      require('catppuccin').setup()
    end,
  },
  {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        dark_variant = 'moon',
        highlight_groups = {
          EndOfBuffer = { fg = 'base', bg = 'base' },
        },
      })
      vim.cmd('colorscheme rose-pine')
    end,
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
    tag = '*',
  },
  { 'ellisonleao/glow.nvim' },
  { 'fladson/vim-kitty' },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end,
  },
}

return packer.startup({
  function()
    for _, plugin in ipairs(plugins) do
      packer.use(plugin)
    end
    if ensure_packer() then
      packer.sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end,
    },
  },
})
