-- set <space> as the leader key
-- `:help mapleader`
-- NOTE: must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'revinder.opt'
require 'revinder.neovide'
require 'revinder.keymap'
require 'revinder.misc'
require 'revinder.health'
