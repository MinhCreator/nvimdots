return {
    -- add more treesitter parsers
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            {
                "folke/ts-comments.nvim",
                opts = {},
            },
        },
        lazy = true,
        build = ":TSUpdate",
        event = "VeryLazy",

        opts = {
            -- ensure_installed = { "lua", "python", "gdscript", "godot_resource", "gdshader" }, --"json","markdown_inline", "markdown",
            highlight = {
                enable = true,
                disable = {},
            },
            indent = { enable = true },
            auto_install = true, -- automatically install syntax support when entering new file type buffer
        },
        config = function(_, opts)
            local configs = require("nvim-treesitter.configs")
            configs.setup(opts)
        end,
    },
}
