--local active_nvim_tree = true
--local neovide = false
--if vim.g.neovide then
--  active_nvim_tree = false
--  neovide = true
return {

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    require("telescope").setup({
      defaults = {
        theme = "center",
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
          --preview_width = 0.4,
        },
      },

      extensions = {
        file_browser = {
          theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
        },
      },
    }),

    -- To get telescope-file-browser loaded and working with telescope,
    -- you need to call load_extension, somewhere after setup function:
    --require("telescope").load_extension("file_browser"),
  },
}
--else
--  return {
--    { "nvim-neo-tree/neo-tree.nvim",           enabled = true },
--    { "nvim-telescope/telescope-file-browser", enabled = false },
--  }
--end
