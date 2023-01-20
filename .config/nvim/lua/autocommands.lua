local cmds = {
  {
    { 'TextYankPost' },
    {
      callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
      end,
      group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    },
  },
  {
    { 'FileType' },
    {
      callback = function()
        for _, v in pairs({ 'spell' }) do
          vim.opt_local[v] = true
        end
      end,
      group = vim.api.nvim_create_augroup('SpellGroup', { clear = true }),
      pattern = { 'gitcommit', 'markdown', 'NeogitCommitMessage' },
    },
  },
}

for _, v in ipairs(cmds) do
  vim.api.nvim_create_autocmd(unpack(v))
end
