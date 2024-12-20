-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 
---@class ChadrcConfig
local M = {}

local core = require "user.utils.core"
local highlights = require "user.highlights"


-- M.base46 = {
-- 	theme = "onedark",

-- 	-- hl_override = {
-- 	-- 	Comment = { italic = true },
-- 	-- 	["@comment"] = { italic = true },
-- 	-- },
-- }

M.ui = {
  lsp_semantic_tokens = false,
  statusline = core.statusline,
  tabufline = core.tabufline,

  cmp = {
    icons = true,
    lspkind_text = true,
    format_colors = {
      tailwind = true,
      icon = "󱓻",
    },
    style = "default",            -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg",     -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
  },

--   telescope = { style = "bordered" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

-- M.nvdash = core.nvdash


M.lsp = { signature = false }

M.mason = {
  pkgs = {
    -- lua stuff
    "lua-language-server",
    "stylua",
    "mypy",
    "pyright",
    "ruff",
    "flake8",
  },
}

M.base46 = {
  integrations = {
    "blankline",
    "cmp",
    "defaults",
    "devicons",
    "git",
    "lsp",
    "markview",
    "mason",
    "nvcheatsheet",
    "nvimtree",
    "statusline",
    "syntax",
    "tbline",
    "telescope",
    "whichkey",
    "dap",
    "hop",
    "treesitter",
    "rainbowdelimiters",
    "diffview",
    "todo",
    "trouble",
    "notify",
  },

  theme = "catppucin-frape", ---@diagnostic disable-line
  theme_toggle = { "catppucin-frape", "one_light" }, ---@diagnostic disable-line

  hl_override = highlights.override,
  hl_add = highlights.add,

  nvdash = core.nvdash,
}

M.colorify = {
  enabled = true,
  mode = "virtual", -- fg, bg, virtual
  virt_text = "󱓻 ",

  highlight = {
    hex = true,
    lspvars = true,
  },
}

M.settings = {
  cc_size = "130",
  so_size = 10,

  -- Blacklisted files where cc and so must be disabled
  blacklist = {
    "NvimTree",
    "nvdash",
    "nvcheatsheet",
    "terminal",
    "Trouble",
    "help",
  },
}

M.lazy_nvim = core.lazy

-- M.gitsigns = {
--   signs = {
--     add = { text = " " },
--     change = { text = " " },
--     delete = { text = " " },
--     topdelete = { text = " " },
--     changedelete = { text = " " },
--     untracked = { text = " " },
--   },
-- }

return M
