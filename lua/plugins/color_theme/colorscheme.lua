return {

  { "projekt0n/github-nvim-theme",   enabled = false },
  { "alexmozaidze/palenight.nvim",   enabled = false },
  { "sekke276/dark_flat.nvim",       enabled = false },
  { "samharju/synthweave.nvim",      enabled = false },
  { "tiagovla/tokyodark.nvim",       enabled = false },
  { "0xstepit/flow.nvim",            enabled = false },
  { "scottmckendry/cyberdream.nvim", enabled = false },
  { "rebelot/kanagawa.nvim",         enabled = false },
  { "navarasu/onedark.nvim",         enabled = true },
  -- { "catppuccin/nvim",               enabled = true },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "onedark", --"dark_flat", --"onedark", --"github_dark_default",--"github_dark_dimmed",--"tokyodark", --"dark_flat", --"cyberdream",
  --   },
  --   -- config = function()
  --   -- vim.api.nvim_command("colorscheme onedark")
  --   -- end
  -- },
  {
    "MinhCreator/base46.nvim",
    event = "VeryLazy",
    lazy = true,
    config = function()
      -- exit if it can't be found
      local present, base46 = pcall(require, "base46")
      if not present then
        return
      end
      local theme = "onedark"
      local color_base = "base46"
      local theme_opts = {
        base = color_base,
        theme = theme,
        transparency = false,
        -- ingore = {"NeoTree"},
  
      }
      base46.load_theme(theme_opts)
    end,
    opts = {
      integrations = {
      alpha = false,
      },
    },
  },
  {
    "notken12/base46-colors",
    enabled = false,
  },
  
}
