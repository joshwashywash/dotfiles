local groups = {
  'IlluminatedWordRead',
  'IlluminatedWordText',
  'IlluminatedWordWrite',
}

for _, group in ipairs(groups) do
  vim.api.nvim_set_hl(0, group, { strikethrough = true })
end

require('illuminate').configure({ delay = 500 })
