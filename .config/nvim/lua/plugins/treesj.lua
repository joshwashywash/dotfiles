return {
  'Wansmer/treesj',
  opts = { use_default_keymaps = false },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    {
      '<space>jj',
      function()
        require('treesj').join()
      end,
      desc = 'join',
    },
    {
      '<space>js',
      function()
        require('treesj').split()
      end,
      desc = 'split',
    },
    {
      '<space>jt',
      function()
        require('treesj').toggle()
      end,
      desc = 'toggle',
    },
  },
}
