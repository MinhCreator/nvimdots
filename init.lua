vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
  { import = "plugins.autocomplete" },
  { import = "plugins.color_theme" },
  { import = "plugins.comment" },
  { import = "plugins.core" },
  { import = "plugins.disable_plugins" },
  { import = "plugins.explorer" },
  { import = "plugins.icon" },
  { import = "plugins.lang" },
  -- { import = "plugins/lsp" },
  { import = "plugins.search" },
  { import = "plugins.terminal" },
  { import = "plugins.todo_comment" },
  { import = "plugins.treesitter" },
  { import = "plugins.ui_menu" },

}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
-- require "nvchad.autocmds"
require "lua.configs.autocmds"
vim.schedule(function()
  require "mappings"
end)
