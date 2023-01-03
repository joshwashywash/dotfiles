local gitsigns = require('gitsigns')
local neogit = require('neogit')
local wk = require('which-key')

gitsigns.setup()

wk.register({
  g = {
    name = 'git',
    D = { gitsigns.diffthis, 'diff' },
    H = { gitsigns.undo_stage_hunk, 'undo stage hunk' },
    N = { gitsigns.prev_hunk, 'previous hunk' },
    P = { neogit.open, 'neogit' },
    R = { gitsigns.reset_buffer, 'reset buffer' },
    b = { gitsigns.blame_line, 'blame' },
    d = { gitsigns.toggle_deleted, 'toggle deleted' },
    h = { gitsigns.stage_hunk, 'stage hunk' },
    n = { gitsigns.next_hunk, 'next hunk' },
    p = { gitsigns.preview_hunk, 'preview hunk' },
    r = { gitsigns.reset_hunk, 'reset hunk' },
    s = { gitsigns.stage_buffer, 'stage buffer' },
  },
}, { prefix = '<leader>' })
