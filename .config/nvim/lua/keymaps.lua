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

  -- make marks a little easier to reach
  { '\'', '`' },
  { '`', '\'' },

  -- center on searches
  { 'N', 'Nzz' },
  { 'n', 'nzz' },

  { '[b', ':bnext<cr>', 'buffer' },
  { ']b', ':bprev<cr>', 'buffer' },
}

local operator_mode_keymaps = {}

local visual_mode_keymaps = {
  { 'p', '"_dP' },

  -- keep cursor in same spot on yank
  { 'y', 'ygv<esc>' },

  -- keep selection on indent
  { '<', '<gv' },
  { '>', '>gv' },
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
