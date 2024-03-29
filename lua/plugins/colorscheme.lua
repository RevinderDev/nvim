return {
  'luisiacc/gruvbox-baby',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'gruvbox-baby'
    -- Dashboard colors
    vim.cmd [[highlight AlphaBanner guifg=#eebd35]]
    vim.cmd [[highlight AlphaHeaderLabel guifg=#E7D7AD]]
    -- Current line number color
    vim.cmd [[highlight CursorLineNR guifg=#fabd2f]]
    vim.cmd [[highlight LspInlayHint guifg=#665c54]]
  end,
}
