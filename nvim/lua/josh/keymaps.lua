vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local common_keymaps = {
  { 'j', 'k' },
  { 'k', 'j' },

  -- center on searches
  { 'n', 'nzz' },
  { 'N', 'Nzz' },

  -- make <home> and <end> easier to reach
  { '<c-l>', '$' },
  { '<c-h>', '^' },
}

local insert_mode_keymaps = {}

local normal_mode_keymaps = {
  -- make setting marks easier
  { '\'', '`' },
  { '`', '\'' },

  -- navigate windows
  { '<c-j>', '<c-w>k' },
  { '<c-k>', '<c-w>j' },
  { '<c-h>', '<c-w>h' },
  { '<c-l>', '<c-w>l' },

  -- move text up and down
  { '<a-k>', ':m .+1<cr>==' },
  { '<a-j>', ':m .-2<cr>==' },

  -- insert a new line without entering insert mode
  { '<bs>', ':i<cr><cr>.<cr><down>' },
  { '<cr>', ':a<cr><cr>.<cr><up>' },
}

local operator_mode_keymaps = {}

local visual_mode_keymaps = {
  -- move text up and down
  { '<a-j>', ':m \'<-2<cr>gv=gv' },
  { '<a-k>', ':m \'>+1<cr>gv=gv' },

  { 'p', '"_dP' },

  -- keep cursor in same spot on yank
  { 'y', 'ygv<esc>' },

  -- keep selection on indent
  { '<', '<gv' },
  { '>', '>gv' },
}

for _, keymap in ipairs({
  normal_mode_keymaps,
  operator_mode_keymaps,
  visual_mode_keymaps,
}) do
  vim.list_extend(keymap, common_keymaps)
end

local maps = {
  i = insert_mode_keymaps,
  n = normal_mode_keymaps,
  o = operator_mode_keymaps,
  v = visual_mode_keymaps,
}

local function map_keys(mode, keymaps)
  for _, keymap in ipairs(keymaps) do
    vim.keymap.set(mode, unpack(keymap))
  end
end

for mode, keymaps in pairs(maps) do
  map_keys(mode, keymaps)
end
