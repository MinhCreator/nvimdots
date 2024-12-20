return {
    "sidebar-nvim/sidebar.nvim",
    enable = false,
    event = "VeryLazy",
    opts = {
        files = {
            icon = "",
            show_hidden = false,
            ignored_paths = { "%.git$" }
        },
        disable_default_keybindings = 0,
        -- "git",
        open = false,
        side = "left",
        initial_width = 35,
        hide_statusline = false,
        update_interval = 1000,
        sections = { "datetime", "files", "diagnostics" },
        section_separator = { "", "-----", "" },
        section_title_separator = { "" },
        -- containers = {
        --     attach_shell = "/bin/sh", show_all = true, interval = 5000,
        -- },
        datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
        todos = { ignored_paths = { "~" } },
    },
}
