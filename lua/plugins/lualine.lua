return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      include_icons = true,
      theme = 'gruvbox-line',
    }
  end,
}
