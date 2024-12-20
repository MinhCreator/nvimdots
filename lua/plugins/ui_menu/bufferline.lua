local bufferline = require("bufferline")



return {
  bufferline.setup {
    options = {

      mode = "buffers",                               -- set to "tabs" to only show tabpages instead
      style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
      --themable = true | false, -- allows highlight groups to be overriden i.e. sets highlights as default
      --numbers = "ordinal",
      -- separator_style = "", --"thin",
      buffer_close_icon = "󰅖",
      modified_icon = "● ",
      close_icon = " ",
      left_trunc_marker = " ",
      right_trunc_marker = " ",
      indicator = {
        icon = "",
        style = "icon",
      },

      -- diagnostics = "nvim_lsp",
      -- diagnostics_update_on_event = true, -- use nvim's diagnostic handler

      -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or " ")
          s = s .. n .. sym
        end
        return s
      end,
      view = 'multiwindow',
      always_show_bufferline = true,
      offsets = {
        text_align = "center",
        {
          filetype = "neo-tree",
          text = "󰉓  File explorer",
          highlight = "Directory",
          --sepactor = true,
          padding = 0.5,
        }
      },
      color_icons = true,       -- whether or not to add the filetype icon highlights

      show_buffer_icons = true, -- disable filetype icons for buffers
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      hover = {
        enabled = true,
        delay = 100,
        reveal = { "close" },
      },
      -- custom_areas = {
      --   right = function()
      --     local result = {}
      --     local seve = vim.diagnostic.severity
      --     local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
      --     local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
      --     local info = #vim.diagnostic.get(0, { severity = seve.INFO })
      --     local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

      --     if error ~= 0 then
      --       table.insert(result, { text = " " .. error, link = "DiagnosticError", bg = "#ff0303" })
      --     end

      --     if warning ~= 0 then
      --       table.insert(result, { text = " " .. warning, link = "DiagnosticWarn", bg = "#f7ac4a" })
      --     end

      --     if hint ~= 0 then
      --       table.insert(result, { text = " " .. hint, link = "DiagnosticHint", bg = "#7a4efc" })
      --     end

      --     if info ~= 0 then
      --       table.insert(result, { text = " " .. info, link = "DiagnosticInfo", bg = "#4edafc" })
      --     end
      --     return result
      --   end,
      -- },
    },
  },

}
