return {
  'saecki/crates.nvim',
  event = { 'BufRead Cargo.toml' },
  config = function()
    require('crates').setup()
    local crates = require 'crates'

    vim.keymap.set('n', '<leader>ct', crates.toggle, { desc = '[c]rates [t]oggle', silent = true })
    vim.keymap.set('n', '<leader>cr', crates.reload, { desc = '[c]rates [r]eload', silent = true })

    vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, { desc = '[c]rates [v]ersions', silent = true })
    vim.keymap.set('n', '<leader>cf', crates.show_features_popup, { desc = '[c]rates [f]eatures', silent = true })
    vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, { desc = '[c]rates [d]ependencies', silent = true })

    vim.keymap.set('n', '<leader>cH', crates.open_homepage, { desc = '[c]rates [H]omepage', silent = true })
    vim.keymap.set('n', '<leader>cR', crates.open_repository, { desc = '[c]rates [r]epository', silent = true })
    vim.keymap.set('n', '<leader>cD', crates.open_documentation, { desc = '[c]rates [D]ocumentation', silent = true })
  end,
}
