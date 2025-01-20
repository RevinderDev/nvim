return { -- fuzzy finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'vimenter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- if encountering errors, see telescope-fzf-native readme for install instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- this is only run then, not every time neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- useful for getting pretty icons, but requires a nerd font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local actions = require 'telescope.actions'
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
      defaults = {
        mappings = {
          i = {
            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
      },
    }

    -- enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'macros')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'emoji')

    -- see `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    local utils = require 'plugins.telescope.utils'

    vim.keymap.set('n', '<leader>sg', utils.live_multigrep, { desc = '[s]earch by [g]rep' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [k]eymaps' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[s]earch [s]elect telescope' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[s]earch [r]esume' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] find existing buffers' })
    vim.keymap.set('n', '<leader>sm', ':Telescope macros<CR>', { desc = 'Telescope [m]acros' })

    vim.keymap.set('n', '<leader>sef', function()
      builtin.find_files {
        prompt_title = 'Find Files in Git Excluded',
        find_command = { 'rg', '--files', '--hidden', '--no-ignore-vcs' },
        search_dirs = { './revinder-local' },
      }
    end, { desc = '[S]earch git [e]xcluded [f]iles' })

    vim.keymap.set('n', '<leader>seg', function()
      builtin.live_grep {
        prompt_title = 'Grep in Git Excluded',
        find_command = { 'rg', '--files', '--hidden', '--no-ignore-vcs' },
        search_dirs = { './revinder-local' },
      }
    end, { desc = '[S]earch git [e]xcluded [g]rep' })

    vim.keymap.set('n', '<leader>sf', function()
      builtin.find_files {
        find_command = {
          'rg',
          '--files',
          '--hidden',
          '--glob',
          '!.git/*',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
        },
      }
    end, { desc = '[s]earch [f]iles including hidden' })

    -- slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- you can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] fuzzily search in current buffer' })

    -- shortcut for searching your neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[s]earch [n]eovim files' })
  end,
}
