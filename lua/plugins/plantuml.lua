return {
  'https://gitlab.com/itaranto/plantuml.nvim',
  version = '*',
  config = function()
    require('plantuml').setup { renderer = { type = 'image' } }
  end,
}
