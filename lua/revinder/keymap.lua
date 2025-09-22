vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<C-q>', vim.cmd.Bdelete) -- quit current buffer
vim.keymap.set('n', '<C-S-s>', vim.cmd.write) -- save
vim.keymap.set('n', '<C-s>', function()
  vim.cmd.Format()
  vim.cmd.write()
end)
vim.keymap.set('n', '<C-S-q>', vim.cmd.qall)
-- diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'show diagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'open diagnostic [q]uickfix list' })
vim.diagnostic.config {
  float = {
    border = 'single',
    focusable = true,
    style = 'minimal',
    source = 'always',
    header = '',
  },
  underline = false,
  update_in_insert = true,
  severity_sort = true,
}
-- exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. otherwise, you normally need to press <c-\><c-n>, which
-- is not what someone will guess without a bit more experience.
--
-- note: this won't work in all terminal emulators/tmux/etc. try your own mapping
-- or just use <c-\><c-n> to exit terminal mode
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'exit terminal mode' })

-- disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "use h to move!!"<cr>')
vim.keymap.set('n', '<right>', '<cmd>echo "use l to move!!"<cr>')
vim.keymap.set('n', '<up>', '<cmd>echo "use k to move!!"<cr>')
vim.keymap.set('n', '<down>', '<cmd>echo "use j to move!!"<cr>')

-- keybinds to make split navigation easier.
--  use ctrl+<hjkl> to switch between windows
--
--  see `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<a-h>', '<c-w><c-h>', { desc = 'move focus to the left window' })
vim.keymap.set('n', '<a-l>', '<c-w><c-l>', { desc = 'move focus to the right window' })
vim.keymap.set('n', '<a-j>', '<c-w><c-j>', { desc = 'move focus to the lower window' })
vim.keymap.set('n', '<a-k>', '<c-w><c-k>', { desc = 'move focus to the upper window' })

vim.keymap.set('n', '<leader>ls', '<cmd>set invspell<cr>', { desc = 'toggle spell checking' })
