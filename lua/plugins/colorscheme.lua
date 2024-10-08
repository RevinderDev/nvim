return {
  'luisiacc/gruvbox-baby',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'gruvbox-baby'

    -- Neotree color correction
    vim.cmd [[hi NeoTreeNormal guibg=NONE]]
    vim.cmd [[hi NeoTreeNormalNC guibg=NONE]]
    -- Dashboard colors
    vim.cmd [[highlight AlphaBanner guifg=#eebd35]]
    vim.cmd [[highlight AlphaHeaderLabel guifg=#E7D7AD]]
    -- Current line number color
    vim.cmd [[highlight CursorLineNR guifg=#fabd2f]]
    vim.cmd [[highlight LspInlayHint guifg=#665c54]]

    -- Splitting line
    vim.cmd [[hi WinSeparator guifg=#665c54]]

    -- Noice popup
    vim.cmd [[hi NoiceCmdlinePopupBorder guifg=#ebdbb2  ]]
    vim.cmd [[hi NoiceCmdlineIcon guifg=#ebdbb2  ]]
  end,
}
