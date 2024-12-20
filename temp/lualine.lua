-- Bubbles config for lualine
local colors = {
  blue = "#80a0ff",
  cyan = "#79dac8",
  black = "#080808",
  white = "#c6c6c6",
  red = "#ff5189",
  green = "#46fa6a",
  grey = "#444544",
  yellow = "#ECBE7B",
  orange = "#f7db07",
  scalet = "#b52121",
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.green },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}
local icons = require("user.icons")
-- local i = icons



local mode = {
  "mode",
  right_padding = 5,
  -- separator = { left = "", },
  -- right_padding = 3,
  fmt = function(str)
    local Nvim_mode = vim.api.nvim_get_mode()["mode"]
    if Nvim_mode == "n" then
      return icons.ui.Vim .. " " .. str
    elseif Nvim_mode == "i" then
      return icons.ui.Edit .. " " .. str
    elseif Nvim_mode == "v" then
      return icons.ui.Visual .. " " .. str
    elseif Nvim_mode == "R" then
      return icons.ui.Replace .. " " .. str
    end
    return icons.ui.Neovim .. " " .. str
  end,
}
local lsp_progress = {}
local data_ok, lspprogress = pcall(require, "lsp-progress")
if data_ok then
  lsp_progress = lspprogress.progress
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local git_file_status = {
  "diff",
  symbols = { added = ' ', modified = ' ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}


require("lualine").setup({
  options = {
    theme = bubbles_theme,
    component_separators = { left = "|", right = "|" }, -- "" ""
    section_separators = { left = "", right = "" },
    always_divide_middle = true,
    disabled_filetypes = {
      "TelescopePrompt",
      "packer",
      --"alpha",
      "dashboard",
      "NvimTree",
      "Outline",
      "DressingInput",
      "toggleterm",
      "lazy",
      "mason",
      --"neo-tree",
      "startuptime",
    },
    refresh = {          -- sets how often lualine should refresh it's contents (in ms)
      statusline = 1000, -- The refresh option sets minimum time that lualine tries
      tabline = 1000,    -- to maintain between refresh. It's not guarantied if situation
      winbar = 1000      -- arises that lualine needs to refresh itself before this time
      -- it'll do it.

      -- Also you can force lualine's refresh by calling refresh function
      -- like require('lualine').refresh()
    },
  },

  sections = {
    lualine_a = {
      mode,

    },
    lualine_b = {
      {
        "branch",
        icon = "󰊢",
        color = { fg = "#fa3628", gui = "bold" },
      },
      {
        "filename",
        file_status = true,     -- Displays file status (readonly status, modified status)
        newfile_status = false, -- Display new file status (new file means no write after created)
        icon = "",
        path = 4,               -- 0: Just the filename
        -- 1: Relative path
        -- 2: Absolute path
        -- 3: Absolute path, with tilde as the home directory
        -- 4: Filename and parent dir, with tilde as the home directory

        shorting_target = 40, -- Shortens path to leave 40 spaces in the window
        -- for other components. (terrible name, any suggestions?)
        symbols = {
          modified = " ", --"[+]",      -- Text to show when the file is modified.
          readonly = " ", --"[-]",      -- Text to show when the file is non-modifiable or readonly.
          unnamed = "[No name]", --"-|Unnamed|-", -- Text to show for unnamed buffers.
          newfile = "[New]", --"-|New|-", -- Text to show for newly created file before first write
        },
        --icon = "",

      },
    },
    lualine_c = {

      --git_file_status,
      -- separator = { right = "" },
      --"progress",
      --"lsp",
      --"lint_progress", --[[ add your center compoentnts here in place of this comment ]]
      --{ '%=', '%t%m', '%3p' },
      -- {
      --   "buffers",
      --   show_filename_only = true,
      --   mode = 0,
      --   hide_filename_extension = false,
      --   show_modified_status = true,
      --   max_length = vim.o.columns * 2 / 3,
      --   use_mode_colors = true,
      --   symbols = {
      --     alternate_file = " ", --" ",
      --   }
      -- },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = "   ", warn = "   ", info = "   ", hint = " 󰌵 " },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.orange },
          info = { fg = colors.cyan },
          hint = { fg = colors.blue },
        },
        position = "center",
      },
    },
    lualine_x = {
      -- {
      --   "diagnostics",
      --   sources = { "nvim_diagnostic" },
      --   symbols = { error = " ", warn = " ", info = " " },
      --   diagnostics_color = {
      --     error = { fg = colors.red },
      --     warn = { fg = colors.yellow },
      --     info = { fg = colors.cyan },
      --   },
      -- },
      lsp_progress,
    },
    lualine_y = {
      "searchcount",
      {
        "filetype",
        colored = true,
        icon = { align = "left" },
        cond = conditions.buffer_not_empty,
      },
      "encoding",
      "fileformat",
    },
    lualine_z = {
      {
        "location",
        -- separator = { right = "" },
        left_padding = 5
      },
    },
  },

  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "encoding" },
    lualine_y = { "location" },
    lualine_z = {
      {
        "fileformat",
        colored = true,
        icon_only = true,
        icon = { align = "center" },

      },
    },
  },
  tabline = {},
  extensions = {},
})
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins/ui_menu.lualine")
    end,
  },
}
