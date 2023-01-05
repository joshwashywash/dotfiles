vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local command_mode_keymaps = {}

local insert_mode_keymaps = {}

local normal_mode_keymaps = {

  -- navigate windows
  { '<c-w>j', '<c-w>k' },
  { '<c-w>k', '<c-w>j' },
  { '<s-down>', '<c-w>j' },
  { '<s-left>', '<c-w>h' },
  { '<s-right>', '<c-w>l' },
  { '<s-up>', '<c-w>k' },

  -- make marks a little easier to reach
  { '\'', '`' },
  { '`', '\'' },

  -- center on searches
  { 'N', 'Nzz' },
  { 'n', 'nzz' },
}

local operator_mode_keymaps = {}

local visual_mode_keymaps = {
  -- move text up and down

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
    vim.keymap.set(mode, unpack(keymap))
  end
end

for mode, keymaps in pairs(maps) do
  map_keys(mode, keymaps)
end
