return { -- useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'vimenter', -- sets the loading event to 'vimenter'
  config = function() -- this is the function that runs, after loading
    require('which-key').setup()

    -- document existing key chains
    require('which-key').add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = '[H]arpoon', mode = { 'n', 'v' } },
    }
  end,
}
