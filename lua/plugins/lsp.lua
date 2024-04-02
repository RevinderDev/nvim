local function ruff_on_attach(client, bufnr)
  if client.name == 'ruff_lsp' then
    client.server_capabilities.hoverProvider = false
  end
end

return { -- lsp configuration & plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- automatically install lsps and related tools to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'whoissethdaniel/mason-tool-installer.nvim',

    -- useful status updates for lsp.
    -- note: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- `neodev` configures lua lsp for your neovim config, runtime and plugins
    -- used for completion, annotations and signatures of neovim apis
    { 'folke/neodev.nvim', opts = {} },
  },

  -- See rustaceanvim.mason for explanation
  setup = {
    ruff_lsp = ruff_on_attach,
    rust_analyzer = function()
      return true
    end,
  },
  config = function()
    vim.api.nvim_create_autocmd('lspattach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'lsp: ' .. desc })
        end

        -- jump to the definition of the word under your cursor.
        --  this is where a variable was first declared, or where a function is defined, etc.
        --  to jump back, press <c-t>.
        map('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')

        -- find references for the word under your cursor.
        map('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')

        -- jump to the implementation of the word under your cursor.
        --  useful when your language has ways of declaring types without an actual implementation.
        map('gi', require('telescope.builtin').lsp_implementations, '[g]oto [i]mplementation')

        -- jump to the type of the word under your cursor.
        --  useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>td', require('telescope.builtin').lsp_type_definitions, 'type [d]efinition')

        -- fuzzy find all the symbols in your current document.
        --  symbols are things like variables, functions, types, etc.
        map('<leader>ts', require('telescope.builtin').lsp_document_symbols, '[d]ocument [s]ymbols')

        -- fuzzy find all the symbols in your current workspace
        --  similar to document symbols, except searches over your whole project.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')

        -- rename the variable under your cursor
        --  most language servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')

        -- execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your lsp for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')

        -- opens a popup that displays documentation about the word under your cursor
        --  see `:help k` for why this keymap
        map('m', vim.lsp.buf.hover, 'hover documentation')

        -- warn: this is not goto definition, this is goto declaration.
        --  for example, in c this would take you to the header
        map('gd', vim.lsp.buf.declaration, '[g]oto [d]eclaration')

        -- the following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    see `:help cursorhold` for information about when this is executed
        --
        -- when you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documenthighlightprovider then
          vim.api.nvim_create_autocmd({ 'cursorhold', 'cursorholdi' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'cursormoved', 'cursormovedi' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      taplo = {
        keys = {
          {
            'K',
            function()
              if vim.fn.expand '%:t' == 'Cargo.toml' and require('crates').popup_available() then
                require('crates').show_popup()
              else
                vim.lsp.buf.hover()
              end
            end,
            desc = 'Show Crate Documentation',
          },
        },
      },
      lua_ls = {
        settings = {
          lua = {
            completion = {
              callsnippet = 'replace',
            },
          },
        },
      },
      ruff_lsp = {
        keys = {
          {
            '<leader>co',
            function()
              vim.lsp.buf.code_action {
                apply = true,
                context = {
                  only = { 'source.organizeImports' },
                  diagnostics = {},
                },
              }
            end,
            desc = 'Organize Imports',
          },
        },
      },
      -- pyright = { settings = { pyright = { disableOrganizingImports = true }, python = { analysis = { ignore = { '*' } } } } },
      pyright = {},
      rust_analyzer = {},
    }
    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- used to format lua code
      -- Python related
      'ruff',
      'ruff-lsp',
      -- Rust
      'codelldb',
      'taplo',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          -- See rustaceanvim.mason for explanation
          if server_name == 'rust_analyzer' then
            return
          end
          local server = servers[server_name] or {}
          -- this handles overriding only values explicitly passed
          -- by the server configuration above. useful when disabling
          -- certain features of an lsp (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
