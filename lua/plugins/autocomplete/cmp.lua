-- Add cmp and snippet configuration
return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function(_, opts)
      require("luasnip.loaders.from_vscode").lazy_load({ path = { "./snippets" } })
      
    end,
  },
  
  -- override nvim-cmp

  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-buffer", -- buffer completions
      "hrsh7th/cmp-path",   -- path completions
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "windwp/nvim-autopairs",
      -- "L3MON4D3/LuaSnip",
    },

    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      -- table.insert(opts.auto_brackets, "python")
      -- table.insert(opts.auto_brackets, "lua")
      -- table.insert(opts.auto_brackets, "json")

      local icon = require("user.icon_cmp")
      local icon_menu = require("user.icons").ui
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      local handlers = require("nvim-autopairs.completion.handlers")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
          filetypes = {
            -- "*" is a alias to all filetypes
            ["*"] = {
              ["("] = {

                kind = {
                  cmp.lsp.CompletionItemKind.Function,
                  cmp.lsp.CompletionItemKind.Method,
                },
                handler = handlers["*"],
              },
            },
            lua = {
              ["("] = {
                kind = {
                  cmp.lsp.CompletionItemKind.Function,
                  cmp.lsp.CompletionItemKind.Method,
                },
                ---@param char string
                ---@param item table item completion
                ---@param bufnr number buffer number
                ---@param rules table
                ---@param commit_character table<string>
                handler = function(char, item, bufnr, rules, commit_character)
                  -- Your handler function. Inspect with print(vim.inspect{char, item, bufnr, rules, commit_character})
                end,
              },
              ["{"] = {
                cmp.lsp.CompletionItemKind.Table,
              },
            },
            -- Disable for tex
            tex = false,
          },
        })
      )

      require("luasnip.loaders.from_vscode").lazy_load({ path = { "./snippets" } })
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }

      opts.formatting = {
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s %s", icon[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
          -- Source
          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            -- latex_symbols = "(LaTeX)",
            lsp = "(LSP)",
          })[entry.source.name]

          if entry.source.name == "calc" then
            vim_item.kind = icon.Calc
            -- return vim_item
          end

          return vim_item
        end,
      }
      opts.window = {
        completion = {
          -- border = icon_menu.Border,
          scrollbar = "",
        },
        documentation = {
          -- border = icon_menu.Border,
          -- scrollbar = nil,
        },
      }
      opts.sources = {
        { name = "nvim_lsp" },
        { name = "lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "crates" },
        { name = "calc" },
        {
          name = "luasnip",
          -- option = {
          --   use_show_condition = true,
          --   --
          -- },
        },
        -- { name = "friendly-snippets" },
      }
    end,
  },
}
