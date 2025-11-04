vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format { async = false, lsp_format = 'fallback', range = range }
end, { range = true })

return { -- autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      rust_analyzer = { 'rustfmt' },
      python = function(bufnr)
        if require('conform').get_formatter_info('ruff', bufnr).available then
          return { 'ruff_format', 'ruff_organize_imports', 'ruff_fix' }
        else
          return { 'isort', 'black' }
        end
      end,
    },
  },
}
