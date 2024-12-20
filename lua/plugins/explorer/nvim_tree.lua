return {
    {
        'nvim-tree/nvim-tree.lua',
        event = "VeryLazy",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = require "user.tree_overrides",
        config = function(_, opts)
            local nvim_tree = require "nvim-tree"
            require "nvim-tree.diagnostics".update()
            nvim_tree.setup({
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
                renderer = {
                    root_folder_modifier = ":t",
                    -- These icons are visible when you install web-devicons
                    icons = {
                        glyphs = {
                            default = "",
                            symlink = "",
                            folder = {
                                arrow_open = "",
                                arrow_closed = "",
                                default = "",
                                open = "",
                                empty = "",
                                empty_open = "",
                                symlink = "",
                                symlink_open = "",
                            },
                            git = {
                                unstaged = "",
                                staged = "S",
                                unmerged = "",
                                renamed = "➜",
                                untracked = "U",
                                deleted = "",
                                ignored = "◌",
                            },
                        },
                    },
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                    icons = {
                        hint = "󰨗",
                        info = "",
                        warning = "",
                        error = "",
                    },
                },
                git = {
                    enable = false,

                },
                view = {
                    width = 30,
                    side = "left",

                },

            })
        end

    },
}
