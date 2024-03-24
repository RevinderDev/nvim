if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.o.guifont = 'JetBrainsMonoNL Nerd Font:h15'
  vim.g.neovide_transparency = 0.9
  vim.keymap.set({ 'n', 'v' }, '<C-9>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<C-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<C-0>', ':lua vim.g.neovide_scale_factor = 1<CR>')
end
