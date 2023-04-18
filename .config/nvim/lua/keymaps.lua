vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local command_mode_keymaps = {}

local insert_mode_keymaps = {}

local normal_mode_keymaps = {

  -- navigate windows
  { '<s-down>', '<c-w>j', 'go to lower window' },
  { '<s-left>', '<c-w>h', 'go to left window' },
  { '<s-right>', '<c-w>l', 'go to right window' },
  { '<s-up>', '<c-w>k', 'go to upper window' },

  { 'j', ':m .-2<cr>==', 'move line up' },
  { 'k', ':m .+1<cr>==', 'move line down' },

  -- make marks a little easier to reach
  { '\'', '`' },
  { '`', '\'' },

  -- center on searches
  { 'N', 'Nzz' },
  { 'n', 'nzz' },

  { ']b', ':bnext<cr>', 'next buffer' },
  { '[b', ':bprev<cr>', 'previous buffer' },
}

local operator_mode_keymaps = {}

local visual_mode_keymaps = {
  { 'p', '"_dP' },

  -- keep cursor in same spot on yank
  { 'y', 'ygv<esc>' },

  -- keep selection on indent
  { '<', '<gv' },
  { '>', '>gv' },

  { 'j', ':m \'<-2<cr>gv=gv', 'move selection up' },
  { 'k', ':m \'>+1<cr>gv=gv', 'move selection down' },
}

local maps = {
  c = command_mode_keymaps,
  i = insert_mode_keymaps,
  n = normal_mode_keymaps,
  o = operator_mode_keymaps,
  x = visual_mode_keymaps,
}

local function map_keys(mode, keymaps)
  for _, keymap in ipairs(keymaps) do
    local l, r, desc = unpack(keymap)
    vim.keymap.set(mode, l, r, { desc = desc })
  end
end

for mode, keymaps in pairs(maps) do
  map_keys(mode, keymaps)
end
