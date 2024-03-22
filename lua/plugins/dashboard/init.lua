local function configure_layout()
  local dashboard = require 'alpha.themes.dashboard'
  local cdir = vim.fn.getcwd()
  local path_ok, plenary_path = pcall(require, 'plenary.path')
  if not path_ok then
    return
  end
  local if_nil = vim.F.if_nil

  local nvim_web_devicons = {
    enabled = true,
    highlight = true,
  }
  local function get_extension(fn)
    local match = fn:match '^.+(%..+)$'
    local ext = ''
    if match ~= nil then
      ext = match:sub(2)
    end
    return ext
  end

  local function icon(fn)
    local nwd = require 'nvim-web-devicons'
    local ext = get_extension(fn)
    return nwd.get_icon(fn, ext, { default = true })
  end

  local function file_button(fn, sc, short_fn, autocd)
    short_fn = short_fn or fn
    local ico_txt
    local fb_hl = {}

    if nvim_web_devicons.enabled then
      local ico, hl = icon(fn)
      local hl_option_type = type(nvim_web_devicons.highlight)
      if hl_option_type == 'boolean' then
        if hl and nvim_web_devicons.highlight then
          table.insert(fb_hl, { hl, 0, #ico })
        end
      end
      if hl_option_type == 'string' then
        table.insert(fb_hl, { nvim_web_devicons.highlight, 0, #ico })
      end
      ico_txt = ico .. '  '
    else
      ico_txt = ''
    end
    local cd_cmd = (autocd and ' | cd %:p:h' or '')
    local file_button_el = dashboard.button(sc, ico_txt .. short_fn, '<cmd>e ' .. vim.fn.fnameescape(fn) .. cd_cmd .. ' <CR>')
    local fn_start = short_fn:match '.*[/\\]'
    if fn_start ~= nil then
      table.insert(fb_hl, { 'Comment', #ico_txt - 2, #fn_start + #ico_txt })
    end
    file_button_el.opts.hl = fb_hl
    return file_button_el
  end

  local default_mru_ignore = { 'gitcommit' }

  local mru_opts = {
    ignore = function(path, ext)
      return (string.find(path, 'COMMIT_EDITMSG')) or (vim.tbl_contains(default_mru_ignore, ext))
    end,
    autocd = false,
  }

  --- @param start number
  --- @param cwd string? optional
  --- @param items_number number? optional number of items to generate, default = 10
  local function mru(start, cwd, items_number, opts)
    opts = opts or mru_opts
    items_number = if_nil(items_number, 5)

    local oldfiles = {}
    for _, v in pairs(vim.v.oldfiles) do
      if #oldfiles == items_number then
        break
      end
      local cwd_cond
      if not cwd then
        cwd_cond = true
      else
        cwd_cond = vim.startswith(v, cwd)
      end
      local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
      if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
        oldfiles[#oldfiles + 1] = v
      end
    end
    local target_width = 35

    local tbl = {}
    for i, fn in ipairs(oldfiles) do
      local short_fn
      if cwd then
        short_fn = vim.fn.fnamemodify(fn, ':.')
      else
        short_fn = vim.fn.fnamemodify(fn, ':~')
      end

      if #short_fn > target_width then
        short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
        if #short_fn > target_width then
          short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
        end
      end

      local shortcut = tostring(i + start - 1)

      local file_button_el = file_button(fn, shortcut, short_fn, opts.autocd)
      tbl[i] = file_button_el
    end
    return {
      type = 'group',
      val = tbl,
      opts = {},
    }
  end
  local banner = {
    type = 'text',
    val = require('plugins.dashboard.banners').dashboard(),
    opts = {
      position = 'center',
      hl = 'AlphaHeader',
    },
  }
  local section_mru = {
    type = 'group',
    val = {
      {
        type = 'text',
        val = 'Recent files',
        opts = {
          hl = 'SpecialComment',
          shrink_margin = false,
          position = 'center',
        },
      },
      { type = 'padding', val = 1 },
      {
        type = 'group',
        val = function()
          return { mru(0, cdir) }
        end,
        opts = { shrink_margin = false },
      },
    },
  }
  local date = os.date '%d %b %y'
  local empty_space = ''

  local plugin_count = {
    type = 'text',
    val = '   Ver: ' .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch,
    opts = {
      position = 'center',
      hl = 'AlphaHeaderLabel',
    },
  }

  local todays_date = {
    type = 'text',
    val = '  ' .. date .. empty_space .. '',
    opts = {
      position = 'center',
      hl = 'AlphaHeaderLabel',
    },
  }

  local buttons = {
    type = 'group',
    val = {
      { type = 'text', val = 'Quick links', opts = { hl = 'SpecialComment', position = 'center' } },
      { type = 'padding', val = 1 },
      dashboard.button('n', '  [N]ew file', '<cmd>ene<CR>'),
      dashboard.button('SPC s f', '󰈞  [S]earch [F]ile'),
      dashboard.button('SPC s g', '󰊄  [S]earch [G]rep'),
      dashboard.button('p', '  [P]lugins', ':Lazy<CR>'),
      dashboard.button('f', '  [F]ile tree', ':Neotree<CR>'),
    },
    position = 'center',
  }

  local fortune_footer = {
    type = 'text',
    val = require 'alpha.fortune'(),
    opts = {
      position = 'center',
      hl = 'Comment',
      hl_shortcut = 'Comment',
    },
  }

  local credits = {
    type = 'text',
    val = '- Config by Revinder -',
    opts = {
      position = 'center',
      hl = 'Comment',
      hl_shortcut = 'Comment',
    },
  }

  local config = {
    layout = {
      banner,
      todays_date,
      plugin_count,
      { type = 'padding', val = 2 },
      section_mru,
      { type = 'padding', val = 2 },
      buttons,
      { type = 'padding', val = 2 },
      fortune_footer,
      { type = 'padding', val = 1 },
      credits,
    },
    opts = {
      margin = 5,
      setup = function()
        vim.api.nvim_create_autocmd('DirChanged', {
          pattern = '*',
          group = 'alpha_temp',
          callback = function()
            cdir = vim.fn.getcwd()
            require('alpha').redraw()
            vim.cmd 'AlphaRemap'
          end,
        })
      end,
    },
  }

  require('alpha').setup(config)
end

return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    'famiu/bufdelete.nvim',
  },
  config = function()
    configure_layout()

    -- If it's the last buffer go to Dashboard
    vim.keymap.set('n', '<C-q>', ':Bdelete<cr>') -- quit current buffer
    local alpha_on_empty = vim.api.nvim_create_augroup('alpha_on_empty', { clear = true })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'BDeletePost*',
      group = alpha_on_empty,
      callback = function(event)
        local fallback_name = vim.api.nvim_buf_get_name(event.buf)
        local fallback_ft = vim.api.nvim_buf_get_option(event.buf, 'filetype')
        local fallback_on_empty = fallback_name == '' and fallback_ft == ''

        if fallback_on_empty then
          require('neo-tree').close_all()
          vim.cmd 'Alpha'
          vim.cmd(event.buf .. 'bwipeout')
        end
      end,
    })
  end,
  opts = function() end,
}
