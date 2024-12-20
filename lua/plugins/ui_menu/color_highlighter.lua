return {
  {
    "NvChad/nvim-colorizer.lua",
    lazy = true,
    opts = {
      "*",    -- Highlight all files, but customize some others.
      "!vim", -- Exclude vim from highlighting.
      -- Exclusion Only makes sense if '*' is specified!
    },
  },
}
