return {

  -- add extras packages, and setup treesitter for json, json5 and jsonc
  -- { import = "lazyvim.plugins.extras.lang.python" },
  -- { "j-hui/fidget.nvim",                        enabled = false },
  { "nvim-lua/popup.nvim",                      lazy = true },
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = "BufReadPre",
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy"
  },
  {
    "mg979/vim-visual-multi",
    lazy = true,
    -- init = function()
    --   vim.g.VM_mouse_mappings = 1              -- equal CTRL + Left Click on VSCODE
    --   vim.g.VM_maps = {
    --     ["Find Under"] = "<C-d>",              -- equal CTRL+D on VSCODE
    --     ["Find Subword Under"] = "<C-d>",      -- equal CTRL+D on VSCODE
    --     ["Select Cursor Down"] = "<M-C-Down>", -- equal CTRL+ALT+DOWN on VSCODE
    --     ["Select Cursor Up"] = "<M-C-Up>",     -- equal CTRL+ALT+UP on VSCODE
    --     ["Undo"] = "u",                        -- undo
    --     ["Redo"] = "<C-r>",                    -- redo
    --   }
    -- end,
  },
  -- { import = "lazyvim.plugins.extras.vscode" },
  { "nvim-neotest/nvim-nio", lazy = true },

  --web devicons
  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = function()
      require("nvim-web-devicons").setup(
        {
          color_icons = true,
        }
      )
    end
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = {
      "FabianWirth/search.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },

    config = function()
      require("plugins/search.search")
    end,
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    lazy = true,
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- Add lsp and formater, linter
  {
    "williamboman/mason.nvim",
    lazy = true,
    opts = {
      ensure_installed = {
        "gdtoolkit",
        "black",
        "mypy",
        "pyright",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "autopep8",
        --"gdtoolkit",
        "ruff",
      },
    },
  },

  -- noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      routes = {
        {
          filter = { event = "notify", find = "No information available" },
          opts = { skip = true },
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  "rcarriga/nvim-notify",


  -- Add context
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
      require("treesitter-context").setup({
        -- max_lines = 5,
        mode = "topline",
      })
    end,
  },

  --Add highlight
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 200,
        filetypes_denylist = {
          "dirvish",
          "fugitive",
          "alpha",
          "NvimTree",
          "packer",
          "neogitstatus",
          "Trouble",
          "lir",
          "Outline",
          "spectre_panel",
          "toggleterm",
          "DressingSelect",
          "TelescopePrompt",
          "neo-tree",
        },
        under_cursor = true,
      })
    end,
  },

  --Add bracket
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter", "VeryLazy" },

    opts = {
      fastwrap = {
        check_comma = true,
        highlight = "PmenuSel",
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = ([[ [%'%"%)%>%]%)%}%,] ]]):gsub("%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        highlight_grey = "LineNr",
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      disable_in_macro = true,        -- disable when recording or executing a macro
      disable_in_visualblock = false, -- disable when insert after visual block mode
      disable_in_replace_mode = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright = true,
      enable_afterquote = true,         -- add bracket pairs after quote
      enable_check_bracket_line = true, --- check bracket in same line
      enable_bracket_in_quote = true,   --
      enable_abbr = false,              -- trigger abbreviation
      break_undo = true,                -- switch for basic rule break undo sequence
      map_cr = true,
      map_bs = true,                    -- map the <BS> key
      map_c_h = false,                  -- Map the <C-h> key to delete a pair
      map_c_w = false,                  -- map <c-w> to delete a pair if possible
      check_ts = true,
      ts_config = {
        python = { "string", "list", "dict", "set" },
      },
      fast_wrap = {},
    },
  },

  -- Add compiler
  { -- This plugin
    "Zeioth/compiler.nvim",
    event = "VeryLazy",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
  },

  { -- The task runner we use
    "stevearc/overseer.nvim",
    event = "VeryLazy",
    commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },

  --LSP progress

  -- {
  --   "linrongbin16/lsp-progress.nvim",
  --   lazy = true,
  --   config = function()
  --     -- require("plugins/ui_menu.lualine")
  --     require("plugins/lsp.lsp_progress")
  --   end,
  -- },

  -- Select virtualenv
  {
    "linux-cultist/venv-selector.nvim",
    event = "VeryLazy",
    branch = "regexp", -- Use this branch for the new version
    cmd = "VenvSelect",

    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    --  Call config for python files and load the cached venv automatically
    ft = "python",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },


  --Add indent rainbow
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    dependencies = { { "HiPhish/rainbow-delimiters.nvim", lazy = true, } },
    opts = function()
      local hooks = require "ibl.hooks"
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)
      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup({
        indent = {
          highlight = highlight,
          char = "▏",
        },
        scope = {
          highlight = highlight,
          -- char = "▏",
        },
      })
      --hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },

  --Big file
  {
    "LunarVim/bigfile.nvim",
    lazy = true,
    event = "BufReadPre",
    opts = {
      filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
    },
    config = function(_, opts)
      require("bigfile").setup(opts)
    end,
  },


  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("plugins.ui_menu.bufferline")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        -- opts = overrides.mason,
        config = function(_, opts)
          require("mason").setup(opts)
          local mr = require "mason-registry"
          mr:on("package:install:success", function()
            vim.defer_fn(function()
              require("lazy.core.handler.event").trigger {
                event = "FileType",
                buf = vim.api.nvim_get_current_buf(),
              }
            end, 100)
          end)
          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
          end, {})
          require "configs.lspconfig"
        end,
      },
      "jubnzv/virtual-types.nvim",
      "williamboman/mason-lspconfig.nvim",

    },
    config = function() end,
  },

  {
    "mawkler/modicator.nvim",
    event = "ModeChanged",
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {
      show_warnings = false,
      highlights = {
        defaults = { bold = true },
      },
    },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },

  {
    "luukvbaal/statuscol.nvim",
    lazy = false,
    config = function()
      require "user.statuscol"
    end,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    cmd = "Refactor",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      prompt_func_return_type = {
        python = true,
      },
      prompt_func_param_type = {
        python = true,
      },
      show_success_message = true,
    },
  },
}
