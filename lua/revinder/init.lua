-- set <space> as the leader key
-- `:help mapleader`
-- NOTE: must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Find out which system we are at
if vim.fn.exists 'g:os' == 0 then
  local is_windows = vim.fn.has 'win64' == 1 or vim.fn.has 'win32' == 1 or vim.fn.has 'win16' == 1
  if is_windows then
    vim.g.os = 'Windows'
  else
    local uname_output = vim.fn.system 'uname'
    vim.g.os = string.gsub(uname_output, '\n', '')
  end
end

require 'revinder.opt'
require 'revinder.neovide'
require 'revinder.keymap'
require 'revinder.misc'
require 'revinder.health'
