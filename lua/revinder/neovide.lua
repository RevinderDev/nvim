if vim.g.neovide then
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_padding_top = 35
  vim.g.neovide_transparency = 0.9
  vim.g.neovide_scale_factor = 1.0

  if vim.g.os == 'Windows' then
    vim.o.guifont = 'JetBrainsMono Nerd Font:h13'
    vim.g.sqlite_clib_path = vim.env.SQLITE_DLL_PATH
    vim.g.python3_host_prog = vim.env.NVIM_PYTHON3_VENV
  elseif vim.g.os == 'Linux' then
    vim.o.guifont = 'IosevkaTerm Nerd Font:h13'
  end

  vim.keymap.set('n', '<C-0>', function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set('n', '<C-9>', function()
    change_scale_factor(1 / 1.25)
  end)
  vim.keymap.set('n', '<C-->', function()
    vim.g.neovide_scale_factor = 1.0
  end)
end
