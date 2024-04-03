if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0

  if vim.g.os == 'Windows' then
    vim.o.guifont = 'JetBrainsMono Nerd Font:h13'
    vim.g.neovide_transparency = 0.9
  elseif vim.g.os == 'Linux' then
    vim.o.guifont = 'IosevkaTerm Nerd Font:h12'
    vim.g.neovide_transparency = 0.9
  end

  vim.keymap.set({ 'n', 'v' }, '<C-9>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<C-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<C-0>', ':lua vim.g.neovide_scale_factor = 1<CR>')
end
