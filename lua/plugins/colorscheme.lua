-- return {
--   'ellisonleao/gruvbox.nvim',
--   priority = 1000,
--   config = true,
--   opts = ...,
--   init = function()
--     vim.cmd.colorscheme 'gruvbox'
--     vim.cmd.hi 'comment gui=none'
--     vim.cmd.hi 'clear signcolumn'
--   end,
-- }
return {
  'luisiacc/gruvbox-baby',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'gruvbox-baby'
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
