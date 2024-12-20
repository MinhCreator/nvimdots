local notify = require("notify")

return {

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      notify.setup {
        fps = 30,
        render = "default",
        timeout = 1500,
        top_down = true,
        opacity = 0.2,

      }
    end,
  },

}
