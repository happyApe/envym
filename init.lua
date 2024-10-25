-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'custom.keymaps'
require 'custom.vim_config'

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

local function require_all_in_directory(dir)
  -- Get the full path for the directory relative to your Neovim config directory
  local config_path = vim.fn.stdpath 'config' .. '/' .. dir

  -- Iterate over all files in the directory
  for _, file in ipairs(vim.fn.readdir(config_path)) do
    -- Only require files ending in '.lua'
    if file:sub(-4) == '.lua' then
      -- Remove .lua extension
      local module_name = file:sub(1, -5)

      -- Build the require path relative to the directory, without 'lua/'
      local require_path = dir:gsub('^lua/', '') .. '/' .. module_name

      -- Normalize slashes for require (Lua uses dots instead of slashes)
      require_path = require_path:gsub('/', '.')

      -- Require the module
      require(require_path)
    end
  end
end

-- which python function to pull the python path to use for dap
function get_python_path()
  local python_path = vim.fn.system 'which python'
  if python_path == '' then
    python_path = '/usr/bin/python'
  end
  return python_path
end
local python_path = get_python_path()
require_all_in_directory 'lua/custom/plugins/config'
require('dap-python').setup(python_path)
