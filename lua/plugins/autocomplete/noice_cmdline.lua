--Check if using neovide or not
-- initial gui app
local is_neovide = false
local use_noice = true
if vim.g.neovide then
  is_neovide = true
  use_noice = false
end
vim.opt.lazyredraw = is_neovide
return {
  {
    "folke/noice.nvim",
    lazy = true,
    enabled = use_noice,
    dependencies = {
      { "MunifTanjim/nui.nvim", enabled = true }, --use_noice },
      { "rcarriga/nvim-notify", },
    },
    event = "BufWinEnter",
    opts = {
      messages = {
        enabled = true,
      },
      notify = {
        enabled = true,
      },
      lsp = {
        progress = {
          enabled = false,
        },
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
    },
    keys = {
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<leader>snl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>snh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>sna",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<c-f>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      },
      {
        "<c-b>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      },
    },
  },

}
