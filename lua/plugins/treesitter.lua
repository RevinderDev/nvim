return { -- highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'VeryLazy',
  opts = {
    ensure_installed = { 'ron', 'bash', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'python', 'rust', 'toml', 'zig', 'dockerfile' },
    -- autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
  },
  config = function(_, opts)
    -- [[ configure treesitter ]] see `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)
    require('nvim-treesitter.install').compilers = { 'zig' }
  end,
}
