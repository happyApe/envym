-- You can add your own plugins here or in other files in this directory!
return {
  {
    'benomahony/uv.nvim',
    -- Optional filetype to lazy load when you open a python file
    -- ft = { python }
    -- Optional dependency, but recommended:
    -- dependencies = {
    --   "folke/snacks.nvim"
    -- or
    --   "nvim-telescope/telescope.nvim"
    -- },
    opts = {
      picker_integration = true,
    },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      -- nvim folding using LSP
      vim.opt.foldcolumn = '0'
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'lsp', 'indent' }
        end,
      }
    end,
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope.nvim' } },
    keys = {
      { '<leader>am', ":lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = 'Harpoon Menu' },
      { '<leader>aa', ":lua require('harpoon.mark').add_file()<CR>", desc = 'add file as marked' },
      { '<leader>ad', ":lua require('harpoon.mark').rm_file()<CR>", desc = 'Remove file' },
      { '<leader>acl', ":lua require('harpoon.mark').clear_all()<CR>", desc = 'Clear all marks' },
      { '<leader>aj', ":lua require('harpoon.ui').nav_next()<CR>", desc = 'Next file ' },
      { '<leader>ak', ":lua require('harpoon.ui').nav_prev()<CR>", desc = 'Prev file ' },
      { '<leader>1', ":lua require('harpoon.ui').nav_file(1)<CR>", desc = '1st file' },
      { '<leader>2', ":lua require('harpoon.ui').nav_file(2)<CR>", desc = '2nd file' },
      { '<leader>3', ":lua require('harpoon.ui').nav_file(3)<CR>", desc = '3rd file' },
      { '<leader>4', ":lua require('harpoon.ui').nav_file(4)<CR>", desc = '4th file' },
      { '<leader>5', ":lua require('harpoon.ui').nav_file(5)<CR>", desc = '5th file' },
    },
  },
  {
    'ellisonleao/glow.nvim',
    cmd = 'Glow',
    config = function()
      require('glow').setup {
        -- glow_path = '', -- will be filled automatically with your glow bin in $PATH, if any
        -- install_path = '~/.local/bin', -- default path for installing glow binary
        border = 'shadow', -- floating window border config
        style = 'dark', -- filled automatically with your current editor background, you can override using glow json style
        pager = false,
        -- width = 80,
        -- height = 100,
        width_ratio = 0.95, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
        height_ratio = 0.95,
      }
    end,
  },
  { 'mbbill/undotree' },
  {
    'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
    config = function()
      require('toggle_lsp_diagnostics').init({ start_on = false }, { underline = true, virtual_text = { prefix = 'XXX', spacing = 5 } }) -- Toggle LSP linter
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('nvim-tree').setup {
        sort_by = 'case_sensitive',
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      }
    end,
  },
  {
    'smoka7/hop.nvim',
    version = '*',
    opts = {},
    lazy = false,
  },
  {
    'nvzone/floaterm',
    dependencies = 'nvzone/volt',
    cmd = 'FloatermToggle',
    opts = {
      size = { h = 60, w = 70 },
      mappings = {
        term = function(buf)
          local api = require 'floaterm.api'

          vim.keymap.set({ 'n', 't' }, '<leader>h', function()
            api.switch_wins()
          end, { buffer = buf, desc = 'Floaterm: switch to sidebar' })

          vim.keymap.set({ 'n', 't' }, '<leader>j', function()
            api.cycle_term_bufs 'prev'
          end, { buffer = buf, desc = 'Floaterm: prev terminal' })

          vim.keymap.set({ 'n', 't' }, '<leader>k', function()
            api.cycle_term_bufs 'next'
          end, { buffer = buf, desc = 'Floaterm: next terminal' })

          -- transparency
          local win = vim.api.nvim_get_current_win()
          vim.api.nvim_win_set_option(win, 'winblend', 10)
        end,
      },
    },
    keys = {
      { [[<c-\>]], '<cmd>FloatermToggle<cr>', desc = 'Toggle floating terminal', mode = { 'n', 't' } },
    },
  },
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    -- event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.g.VM_theme = 'purplegray'
      vim.g.VM_mouse_mappings = 1
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = true,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = 'hard', -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
  },
  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    opts = {
      terminal_cmd = '/Users/quack/.local/bin/claude',
      auto_start = true,
      log_level = 'info',
      focus_after_send = false,
      track_selection = true,
      terminal = {
        provider = 'snacks',
        auto_close = true,
        snacks_win_opts = {
          position = 'float',
          width = 0.9,
          height = 0.9,
          border = 'rounded',
          backdrop = 80,
          keys = {
            claude_hide = {
              '<C-,>',
              function(self)
                self:hide()
              end,
              mode = 't',
              desc = 'Hide Claude',
            },
          },
        },
      },
      diff_opts = {
        layout = 'vertical',
        open_in_new_tab = false,
        keep_terminal_focus = false,
      },
    },
    config = true,
    keys = {
      { '<C-,>', '<cmd>ClaudeCodeFocus<cr>', desc = 'Toggle Claude float', mode = { 'n', 'x' } },
      { '<leader>cc', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
      { '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
      { '<leader>cr', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
      { '<leader>cC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
      { '<leader>cm', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
      { '<leader>cb', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
      { '<leader>cs', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
      {
        '<leader>cs',
        '<cmd>ClaudeCodeTreeAdd<cr>',
        desc = 'Add file',
        ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
      },
      { '<leader>ca', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
      { '<leader>cd', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    },
  },
  { -- Custom Theme inspired from original VIM
    'EdenEast/nightfox.nvim', -- colorscheme
    opts = {
      options = {
        terminal_colors = true,
        styles = {
          comments = 'italic',
          functions = 'bold',
          -- constants = "italic",
          -- keywords = "standout",
        },
      },
      specs = {
        all = {
          syntax = {
            keyword = '#FFFA3E',
            func = '#00FFFF',
            string = '#D936E8',
            number = '#9300FF',
            conditional = '#E77C0C',
            variable = '#FFFFFF',
            operator = '#FFFA3E',
            comment = '#56BD37',
          },
        },
      },
      palettes = {
        carbonfox = {
          bg1 = '#000000', -- Pure Black background babyy
          sel0 = '#3e4a5b', -- Popup bg, visual selection bg
          sel1 = '#4f6074', -- Popup sel bg, search bg
          -- comment = "#E1C16E",
        },
      },
    },
  },
}
