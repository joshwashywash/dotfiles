local cmds = {
  ['TextYankPost'] = {
    callback = function()
      vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
    end,
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  },
  ['FileType'] = {
    callback = function()
      for _, v in pairs({ 'wrap', 'spell' }) do
        vim.opt_local[v] = true
      end
    end,
    group = vim.api.nvim_create_augroup('MarkdownGroup', { clear = true }),
    pattern = 'markdown',
  },
}

for k, v in pairs(cmds) do
  vim.api.nvim_create_autocmd(k, v)
end
