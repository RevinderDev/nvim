return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Move to previous/next
      map('n', '<A-1>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<A-2>', '<Cmd>BufferNext<CR>', opts)
      --[[ map('n', '<A-q>', '<Cmd>BufferClose<CR>', opts) ]]
    end,
    opts = {
      animation = false,
      no_name_title = nil,
      icons = {
        separator_at_end = false,
      },
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
}
