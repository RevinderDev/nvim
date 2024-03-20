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
    vim.cmd.hi 'comment gui=none'
    vim.cmd.hi 'clear signcolumn'
  end,
}
