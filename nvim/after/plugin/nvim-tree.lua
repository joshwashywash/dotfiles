vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvimtree = require('nvim-tree')

-- key -> nvim function name
local keymaps = {
  { '..', 'dir_up' },
  { './', 'cd' },
  { '<bs>', 'close_node' },
  { '<c-d>', 'toggle_dotfiles' },
  { '<c-r>', 'refresh' },
  { '<c-y>', 'copy_absolute_path' },
  { '<cr>', 'edit' },
  { '<tab>', 'preview' },
  { 'C', 'collapse_all' },
  { 'D', 'trash' },
  { 'E', 'expand_all' },
  { 'I', 'toggle_ignored' },
  { 'K', 'toggle_file_info' },
  { 'P', 'parent_node' },
  { 'R', 'full_rename' },
  { 'Y', 'copy_path' },
  { 'a', 'create' },
  { 'c', 'copy' },
  { 'd', 'remove' },
  { 'g?', 'toggle_help' },
  { 'gj', 'first_sibling' },
  { 'gk', 'last_sibling' },
  { 'gn', 'next_git_item' },
  { 'gp', 'prev_git_item' },
  { 'h', 'split' },
  { 'mm', 'toggle_mark' },
  { 'mp', 'bulk_move' },
  { 'o', 'system_open' },
  { 'p', 'paste' },
  { 'r', 'rename' },
  { 'v', 'vsplit' },
  { 'x', 'cut' },
  { 'y', 'copy_name' },
  { { 'q', '<esc>' }, 'close' },
}

local function create_keymap(keymap)
  local key, action = unpack(keymap)
  return { key = key, action = action }
end

nvimtree.setup({
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  renderer = {
    icons = {
      show = {
        folder_arrow = false,
      },
    },
  },
  view = {
    mappings = {
      custom_only = true,
      list = vim.tbl_map(create_keymap, keymaps),
    },
    side = 'right',
  },
})
