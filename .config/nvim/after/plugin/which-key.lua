local bufdelete = require('bufdelete')
local packer = require('packer')
local wk = require('which-key')

wk.register({
  b = {
    name = 'buffer actions',
    d = {
      function()
        bufdelete.bufdelete(0)
      end,
      'delete',
    },
    D = {
      function()
        vim.cmd('%bdelete')
      end,
      'delete all buffers',
    },
    w = {
      function()
        bufdelete.bufwipeout(0)
      end,
      'wipeout',
    },
    W = {
      function()
        vim.cmd('%bwipeout')
      end,
      'wipeout all buffers',
    },
    n = {
      vim.cmd.bnext,
      'next',
    },
    N = {
      vim.cmd.bprevious,
      'previous',
    },
  },
  p = {
    name = 'packer',
    S = { packer.status, 'status' },
    s = { packer.sync, 'sync' },
  },
}, { prefix = '<leader>' })
