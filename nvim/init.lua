local files = {
  'filetypes',
  'autocommands',
  'keymaps',
  'options',
  'plugins',
  'usercommands',
}

for _, file in ipairs(files) do
  require(string.format('josh.%s', file))
end
