require('impatient')

local files = {
  'autocommands',
  'usercommands',
  'keymaps',
  'options',
  'plugins',
}

for _, file in ipairs(files) do
  require(string.format('josh.%s', file))
end
