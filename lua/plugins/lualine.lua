return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      include_icons = true,
      options = { disabled_filetypes = { 'alpha' }, theme = 'gruvbox' },
      sections = {
        lualine_c = { { 'filename', path = 1, shorting_target = 40 } },
      },
    }
  end,
}
