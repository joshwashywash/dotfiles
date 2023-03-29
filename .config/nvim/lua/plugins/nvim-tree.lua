local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local keymaps = {
    { 'n', '..', api.tree.change_root_to_parent, 'up' },
    { 'n', './', api.tree.change_root_to_node, 'cd' },
    { 'n', '<bs>', api.node.navigate.parent_close, 'close directory' },
    { 'n', '<c-d>', api.tree.toggle_hidden_filter, 'toggle dotfiles' },
    { 'n', '<c-r>', api.tree.reload, 'refresh' },
    { 'n', '<c-y>', api.fs.copy.absolute_path, 'copy absolute path' },
    { 'n', '<cr>', api.node.open.edit, 'open' },
    { 'n', '<esc>', api.tree.close, 'close' },
    { 'n', '<tab>', api.node.open.preview, 'open preview' },
    { 'n', 'C', api.tree.collapse_all, 'collapse' },
    { 'n', 'D', api.fs.trash, 'trash' },
    { 'n', 'E', api.tree.expand_all, 'expand all' },
    { 'n', 'I', api.tree.toggle_gitignore_filter, 'toggle git ignore' },
    { 'n', 'K', api.node.show_info_popup, 'info' },
    { 'n', 'P', api.node.navigate.parent, 'parent directory' },
    { 'n', 'R', api.fs.rename_sub, 'rename: omit filename' },
    { 'n', 'Y', api.fs.copy.relative_path, 'copy relative path' },
    { 'n', 'a', api.fs.create, 'create' },
    { 'n', 'c', api.fs.copy.node, 'copy' },
    { 'n', 'd', api.fs.remove, 'delete' },
    { 'n', 'g?', api.tree.toggle_help, 'help' },
    { 'n', 'gj', api.node.navigate.sibling.first, 'first sibling' },
    { 'n', 'gk', api.node.navigate.sibling.last, 'last sibling' },
    { 'n', 'gn', api.node.navigate.git.next, 'next git' },
    { 'n', 'gp', api.node.navigate.git.prev, 'prev git' },
    { 'n', 'h', api.node.open.horizontal, 'open with horz split' },
    { 'n', 'mm', api.marks.toggle, 'toggle bookmark' },
    { 'n', 'mp', api.marks.bulk.move, 'move bookmarked' },
    { 'n', 'o', api.node.run.system, 'run system' },
    { 'n', 'p', api.fs.paste, 'paste' },
    { 'n', 'q', api.tree.close, 'close' },
    { 'n', 'r', api.fs.rename, 'rename' },
    { 'n', 'v', api.node.open.vertical, 'open with vert split' },
    { 'n', 'x', api.fs.cut, 'cut' },
    { 'n', 'y', api.fs.copy.filename, 'copy name' },
  }

  for _, value in pairs(keymaps) do
    local left, right, fn, desc = unpack(value)
    vim.keymap.set(left, right, fn, {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    })
  end
end

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      '<leader>ef',
      function()
        vim.cmd('NvimTreeFindFileToggle')
      end,
      desc = 'find file in explorer',
    },
    {
      '<leader>et',
      function()
        vim.cmd('NvimTreeToggle')
      end,
      desc = 'toggle explorer',
    },
  },
  opts = {
    actions = {
      open_file = {
        quit_on_open = true,
      },
      file_popup = {
        open_win_config = {
          border = 'rounded',
        },
      },
    },
    on_attach = on_attach,
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
      },
      side = 'right',
    },
  },
}
