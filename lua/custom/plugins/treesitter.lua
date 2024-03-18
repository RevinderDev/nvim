return { -- highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':tsupdate',
  opts = {
    ensure_installed = { 'bash', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'python', 'rust', 'toml' },
    -- autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- some languages depend on vim's regex highlighting system (such as ruby) for indent rules.
      --  if you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    -- [[ configure treesitter ]] see `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)
    require('nvim-treesitter.install').compilers = { 'zig' }
  end,
}
