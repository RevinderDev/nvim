-- nvim v0.8.0
return {
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    init = function()
      vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'Turn on lazygit' })
    end,
  },
}
