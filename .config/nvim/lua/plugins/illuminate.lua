return {
  'RRethy/vim-illuminate',
  config = function(_, opts)
    local groups = {
      'IlluminatedWordRead',
      'IlluminatedWordText',
      'IlluminatedWordWrite',
    }

    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { strikethrough = true })
    end

    require('illuminate').configure(opts)
  end,
  event = 'BufReadPost',
  keys = {
    {
      ']]',
      function()
        require('illuminate').goto_next_reference(false)
      end,
      desc = 'Next reference',
    },
    {
      '[[',
      function()
        require('illuminate').goto_prev_reference(false)
      end,
      desc = 'Prev reference',
    },
  },
  opts = { delay = 500 },
}
