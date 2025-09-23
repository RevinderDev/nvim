return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      override = {
        -- override the default lsp markdown formatter with Noice
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        -- override the lsp markdown formatter with Noice
        ['vim.lsp.util.stylize_markdown'] = true,
        -- override cmp documentation with Noice (needs the other options to work)
        ['cmp.entry.get_documentation'] = true,
      },
    },
    views = {
      cmdline_popup = {
        position = {
          row = 5,
          col = '50%',
        },
        size = {
          width = 60,
          height = 'auto',
        },
      },
      popupmenu = {
        relative = 'editor',
        position = {
          row = 8,
          col = '50%',
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = 'rounded',
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
        },
      },
    },
    presets = {
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = false, -- long messages will be sent to a split
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    routes = {
      {
        -- Filter no information available
        filter = {
          event = 'notify',
          find = 'No information available',
        },
        opts = { skip = true },
      },
      -- Show recording messages
      {
        view = 'notify',
        filter = { event = 'msg_showmode' },
      },
      {
        -- Hide "Written" messages
        filter = {
          event = 'msg_show',
          find = 'written',
        },
        opts = { skip = true },
      },
    },
  },
  dependencies = {
    'folke/noice.nvim',
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}
