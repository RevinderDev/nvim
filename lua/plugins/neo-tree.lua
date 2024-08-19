return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  keys = {
    {
      '<C-g>',
      function()
        require('neo-tree.command').execute { source = 'git_status', toggle = true }
      end,
      desc = 'Git Explorer',
    },
    {
      '<C-e>',
      function()
        require('neo-tree.command').execute { toggle = true, dir = vim.uv.cwd() }
      end,
      desc = 'Explorer NeoTree (cwd)',
    },
  },
  deactivate = function()
    vim.cmd [[Neotree close]]
  end,
  config = function()
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
            '.ruff_cache',
          },
        },
      },
    }
  end,
}
