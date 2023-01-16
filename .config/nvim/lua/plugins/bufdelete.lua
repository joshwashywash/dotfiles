return {
  'famiu/bufdelete.nvim',
  keys = {
    {
      '<leader>bd',
      function()
        require('bufdelete').bufdelete(0)
      end,
      desc = 'delete',
    },
    {
      '<leader>bD',
      function()
        require('bufdelete').bufdelete(0, true)
      end,
      desc = 'force delete',
    },
    {
      '<leader>bw',
      function()
        require('bufdelete').bufwipeout(0)
      end,
      desc = 'wipeout',
    },
    {
      '<leader>bW',
      function()
        require('bufdelete').bufwipeout(0)
      end,
      desc = 'force wipeout',
    },
  },
}
