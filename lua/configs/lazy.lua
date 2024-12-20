local icons = require("user.icons").ui

return {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },

  ui = {
    icons = {
      ft = icons.ft,                 --"",
      lazy = icons.Bell,             --"󰂠 ",
      loaded = icons.CheckCircle,    --"",
      not_loaded = icons.not_loaded, --"",
    },
    border = "rounded",
    backdrop = 100,
  },
  checker = {
    enabled = false, -- check for plugin updates periodically
    notify = true,   -- notify on update
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}
