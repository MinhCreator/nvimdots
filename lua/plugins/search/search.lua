return {
  require("telescope").setup({
    defaults = {
      -- configure to use ripgrep
      vimgrep_arguments = {
        "rg",
        "--follow",        -- Follow symbolic links
        "--hidden",        -- Search for hidden files
        "--no-heading",    -- Don't group matches by each file
        "--with-filename", -- Print the file path with the matched lines
        "--line-number",   -- Show line numbers
        "--column",        -- Show column numbers
        "--smart-case",    -- Smart case search

        -- Exclude some patterns from search
        "--glob=!**/.git/*",
        "--glob=!**/.idea/*",
        "--glob=!**/.vscode/*",
        "--glob=!**/build/*",
        "--glob=!**/dist/*",
        "--glob=!**/yarn.lock",
        "--glob=!**/package-lock.json",
        "--glob=!**/.",
      },
      path_display = { 'smart' },
      prompt_prefix = "  ", --"  ",
      selection_caret = " ", --" ",
      entry_prefix = "  ",
      initial_mode = "insert", --"normal",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal", --"vertical",
      previewer = false,
      layout_config = {
        horizontal = {
          prompt_position = "bottom", --"top",
          preview_width = 0.55,
          results_width = 0.8,
          -- mirror = false,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87, --0.87,
        height = 0.81,
        preview_cutoff = 120,
      },
      winblend = 0,
      -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      borderchars = { " ", "", "", "", "", "", "", "" },
      color_devicons = true,
      use_less = true,
      -- set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_ignore_patterns = {
        "node_modules",
        "dist",
        "build",
        "yarn.lock",
        "package-lock.json",
        "coverage",
        ".git",
        "__pycache__",
        ".vscode",
        ".idea",
        ".cache",
        ".pytest_cache",
        ".mypy_cache",
        ".ipynb_checkpoints",
        ".pytest_cache",
      },
      pickers = {
        find_files = {
          hidden = true,
          -- needed to exclude some files & dirs from general search
          -- when not included or specified in .gitignore
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob=!**/.git/*",
            "--glob=!**/.idea/*",
            "--glob=!**/.vscode/*",
            "--glob=!**/build/*",
            "--glob=!**/dist/*",
            "--glob=!**/yarn.lock",
            "--glob=!**/package-lock.json",
            "--glob=!**/.",
            "!.gitignore",
          },
        },
        lsp_code_actions = {
          theme = 'cursor',

        },
        colorscheme = {
          previewer = true,
          enabled_preview = false,

        },
      },

    },
  }),
  require("telescope").load_extension("notify"),
  require "telescope" .load_extension "ui-select"
  -- require("telescope").load_extension("noice"),
  -- require("telescope").load_extension("themes")
}
