return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    vim.keymap.set('n', '<C-e>', '<cmd>Neotree toggle<cr>')
    require('neo-tree').setup {
      popup_border_style = 'rounded',
      window = {
        position = 'right',
        width = 45,
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          never_show = {
            '.git',
            '.venv',
            '__pycache__',
            '.mypy_cache',
            '.pytest_cache',
          },
        },
      },
    }
  end,
}
