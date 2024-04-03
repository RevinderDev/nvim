return {
  'shellRaining/hlchunk.nvim',
  event = { 'UIEnter' },
  config = function()
    require('hlchunk').setup {
      chunk = {
        enable = true,
        use_treesitter = true,
        style = {
          { fg = '#fabd2f' },
          { fg = '#c21f30' }, -- this fg is used to highlight wrong chunk
        },
      },
      blank = { enable = false },
      line_num = { enable = true, use_treesitter = true, style = '#fabd2f' },
    }
  end,
}
