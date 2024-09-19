return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = true,
  ft = { 'rust' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'lvimuser/lsp-inlayhints.nvim',
      opts = {
        inlay_hints = {
          parameter_hints = {
            show = true,
            prefix = '<- ',
            separator = ', ',
            remove_colon_start = true,
            remove_colon_end = true,
          },
          type_hints = {
            -- type and other hints
            show = true,
            prefix = '-> ',
            separator = ', ',
            remove_colon_start = true,
            remove_colon_end = false,
          },
        },
      },
    },
  },
  opts = {
    server = {
      on_attach = function(client, bufnr)
        require('lsp-inlayhints').on_attach(client, bufnr)
        vim.keymap.set('n', '<leader>cR', function()
          vim.cmd.RustLsp 'codeAction'
        end, { desc = 'Code Action', buffer = bufnr })
        vim.keymap.set('n', '<leader>dr', function()
          vim.cmd.RustLsp 'debuggables'
        end, { desc = 'Rust Debuggables', buffer = bufnr })
      end,
      default_settings = {
        -- rust-analyzer language server configuration
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true,
          },
          -- Add clippy lints for Rust.
          checkOnSave = {
            allFeatures = true,
            command = 'clippy',
            extraArgs = { '--no-deps' },
          },
          procMacro = {
            enable = true,
            ignored = {
              ['async-trait'] = { 'async_trait' },
              ['napi-derive'] = { 'napi' },
              ['async-recursion'] = { 'async_recursion' },
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
  end,
}
