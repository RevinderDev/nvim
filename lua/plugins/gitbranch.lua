return {
  'rbong/vim-flog',
  lazy = true,
  cmd = { 'Flog', 'Flogsplit', 'Floggit' },
  dependencies = {
    'tpope/vim-fugitive',
  },
  keys = {
    {
      '<leader>lb',
      '<cmd>Flog<cr>',
      desc = 'Git [B]ranch',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ll',
      '<cmd>Git blame<cr>',
      desc = 'Git B[l]ame',
      mode = { 'n', 'v' },
    },
  },
}
