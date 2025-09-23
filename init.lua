require 'revinder'

-- `lazy.nvim` plugin manager
--    see `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Smart comments
  -- "gc" to comment visual regions/lines
  { 'numtostr/comment.nvim', opts = {} },

  -- highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'vimenter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = true } },
  {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      -- better around/inside textobjects
      -- examples:
      --  - va)  - [v]isually select [a]round [)]paren
      --  - yinq - [y]ank [i]nside [n]ext [']quote
      --  - ci'  - [c]hange [i]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [s]urround [a]dd [i]nner [w]ord [)]paren
      -- - sd'   - [s]urround [d]elete [']quotes
      -- - sr)'  - [s]urround [r]eplace [)] [']
      require('mini.surround').setup()

      -- Bracket pairs
      require('mini.pairs').setup()
    end,
  },

  { import = 'plugins' },
}
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
