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

    -- NOTE: What were these for..
    --[[ vim.cmd.hi 'comment gui=none' ]]
    --[[ vim.cmd.hi 'clear signcolumn' ]]
    -- In case using nvim not neovide
    -- vim.cmd.hi 'Normal guibg=none'
    -- vim.cmd.hi 'NonText guibg=none'
    -- vim.cmd.hi 'Normal ctermbg=none'
    -- vim.cmd.hi 'NonText ctermbg=none'
  end,
}
