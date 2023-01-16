return {
  { 'ellisonleao/glow.nvim', cmd = 'Glow' },
  { 'famiu/bufdelete.nvim' },
  {
    'folke/todo-comments.nvim',
    config = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  { 'karb94/neoscroll.nvim', opts = { easing_function = 'sine' } },
  { 'kylechui/nvim-surround', config = true },
  { 'monaqa/dial.nvim', keys = { '<c-a>', '<c-x>' } },
  { 'norcalli/nvim-colorizer.lua', config = true },
  { 'numToStr/Comment.nvim', config = true, keys = { 'gb', 'gc' } },
  { 'nvim-lua/plenary.nvim' },
  { 'stevearc/dressing.nvim', event = 'VeryLazy' },
  { 'windwp/nvim-autopairs', config = true },
  {
    'windwp/nvim-ts-autotag',
    config = true,
    ft = { 'html', 'php', 'svelte' },
  },
}
