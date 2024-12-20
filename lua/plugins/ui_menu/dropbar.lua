local icon = require("user.icon_cmp")
return {
    --Add dropbar
    {
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            "nvim-tree/nvim-web-devicons",
        },
        -- enabled = false,
        event = { "BufNewFile", "BufRead" },
        lazy = true,
        opts = {
            icons = {
                kind = {
                    use_devicons = true,
                    symbols = {
                        Array = icon.Array, --'󰅪 ',
                        Boolean = icon.Boolean, --' ',
                        BreakStatement = '󰙧 ',
                        Call = " ", --"󱁗 ", --'󰃷 ',
                        CaseStatement = '󱃙 ',
                        Class = ' ',
                        Color = '󰏘 ',
                        Constant = icon.Constant, --'󰏿 ',
                        Constructor = icon.Constructor,
                        ' ',
                        ContinueStatement = '→ ',
                        Copilot = ' ',
                        Declaration = '󰙠 ',
                        Delete = '󰩺 ',
                        DoStatement = '󰑖 ',
                        Enum = ' ',
                        EnumMember = ' ',
                        Event = ' ',
                        Field = ' ',
                        File = '󰈔 ',
                        Folder = '󰉋 ',
                        ForStatement = '󰑖 ',
                        Function = ' ', --'󰊕 ',
                        H1Marker = '󰉫 ', -- Used by markdown treesitter parser
                        H2Marker = '󰉬 ',
                        H3Marker = '󰉭 ',
                        H4Marker = '󰉮 ',
                        H5Marker = '󰉯 ',
                        H6Marker = '󰉰 ',
                        Identifier = '󰀫 ',
                        IfStatement = '󰇉 ',
                        Interface = ' ',
                        Keyword = '󰌋 ',
                        List = '󰅪 ',
                        Log = '󰦪 ',
                        Lsp = ' ',
                        Macro = '󰁌 ',
                        MarkdownH1 = '󰉫 ', -- Used by builtin markdown source
                        MarkdownH2 = '󰉬 ',
                        MarkdownH3 = '󰉭 ',
                        MarkdownH4 = '󰉮 ',
                        MarkdownH5 = '󰉯 ',
                        MarkdownH6 = '󰉰 ',
                        Method = '󰆧 ',
                        Module = '󰏗 ',
                        Namespace = '󰅩 ',
                        Null = '󰢤 ',
                        Number = '󰎠 ',
                        Object = '󰅩 ',
                        Operator = '󰆕 ',
                        Package = '󰆦 ',
                        Pair = '󰅪 ',
                        Property = ' ',
                        Reference = '󰦾 ',
                        Regex = ' ',
                        Repeat = '󰑖 ',
                        Scope = '󰅩 ',
                        Snippet = '󰩫 ',
                        Specifier = '󰦪 ',
                        Statement = '󰅩 ',
                        String = '󰉾 ',
                        Struct = ' ',
                        SwitchStatement = '󰺟 ',
                        Terminal = ' ',
                        Text = ' ',
                        Type = ' ',
                        TypeParameter = '󰆩 ',
                        Unit = ' ',
                        Value = '󰎠 ',
                        Variable = '󰀫 ',
                        WhileStatement = '󰑖 ',
                    },
                },
                ui = {
                    bar = {
                        separator = " > ", --' ',
                        extends = '…',
                    },
                    menu = {
                        separator = ' ',
                        indicator = ' ',
                    },
                },
            },

            symbol = {
                preview = {
                    reorient = {
                        range = function(_, range)
                            local invisible = range['end'].line - vim.fn.line('w$') + 1
                            if invisible > 0 then
                                local view = vim.fn.winsaveview() --[[@as vim.fn.winrestview.dict]]
                                view.topline = math.min(
                                    view.topline + invisible,
                                    math.max(1, range.start.line - vim.wo.scrolloff + 1)
                                )
                                vim.fn.winrestview(view)
                            end
                        end,
                    },
                },
            },

            bar = {
                hover = true,

                sources = function(buf, _)
                    local sources = require('dropbar.sources')
                    local utils = require('dropbar.utils')
                    if vim.bo[buf].ft == 'markdown' then
                        return {
                            sources.path,
                            sources.markdown,
                        }
                    end
                    if vim.bo[buf].buftype == 'terminal' then
                        return {
                            sources.terminal,
                        }
                    end
                    return {
                        sources.path,
                        utils.source.fallback({
                            sources.lsp,
                            sources.treesitter,
                        }),
                    }
                end,

                truncate = true,
                attach_events = {
                    'OptionSet',
                    'BufWinEnter',
                    'BufWritePost',
                },
                update_events = {
                    win = {
                        'CursorMoved',
                        'CursorMovedI',
                        'WinEnter',
                        'WinResized',
                    },
                    buf = {
                        'BufModifiedSet',
                        'FileChangedShellPost',
                        'TextChanged',
                        'TextChangedI',
                    },
                    global = {
                        'DirChanged',
                        'VimResized',
                    },
                },
                function(buf, win, _)
                    return vim.api.nvim_buf_is_valid(buf)
                        and vim.api.nvim_win_is_valid(win)
                        and vim.wo[win].winbar == ''
                        and vim.fn.win_gettype(win) == ''
                        and vim.bo[buf].ft ~= 'help'
                        and ((pcall(vim.treesitter.get_parser, buf)) and true or false)
                end,
            },

            menu = {
                quick_navigation = true,
                preview = true,
                scrollbar = {
                    enabled = false,
                    background = false,
                },
                win_configs = {
                    border = 'rounded',
                    style = 'minimal',
                    row = function(menu)
                        return menu.prev_menu
                            and menu.prev_menu.clicked_at
                            and menu.prev_menu.clicked_at[1] - vim.fn.line('w0')
                            or 0
                    end,
                    ---@param menu dropbar_menu_t
                    col = function(menu)
                        if menu.prev_menu then
                            return menu.prev_menu._win_configs.width
                                + (menu.prev_menu.scrollbar and 1 or 0)
                        end
                        local mouse = vim.fn.getmousepos()
                        local bar = require('dropbar.api').get_dropbar(
                            vim.api.nvim_win_get_buf(menu.prev_win),
                            menu.prev_win
                        )
                        if not bar then
                            return mouse.wincol
                        end
                        local _, range = bar:get_component_at(math.max(0, mouse.wincol - 1))
                        return range and range.start or mouse.wincol
                    end,
                    relative = 'win',
                    win = function(menu)
                        return menu.prev_menu and menu.prev_menu.win
                            or vim.fn.getmousepos().winid
                    end,
                    height = function(menu)
                        return math.max(
                            1,
                            math.min(
                                #menu.entries,
                                vim.go.pumheight ~= 0 and vim.go.pumheight
                                or math.ceil(vim.go.lines / 4)
                            )
                        )
                    end,
                    width = function(menu)
                        local min_width = vim.go.pumwidth ~= 0 and vim.go.pumwidth or 8
                        if vim.tbl_isempty(menu.entries) then
                            return min_width
                        end
                        return math.max(
                            min_width,
                            math.max(unpack(vim.tbl_map(function(entry)
                                return entry:displaywidth()
                            end, menu.entries)))
                        )
                    end,
                    zindex = function(menu)
                        if menu.prev_menu then
                            if menu.prev_menu.scrollbar and menu.prev_menu.scrollbar.thumb then
                                return vim.api.nvim_win_get_config(menu.prev_menu.scrollbar.thumb).zindex
                            end
                            return vim.api.nvim_win_get_config(menu.prev_win).zindex
                        end
                    end,
                },
            },


        },

    },
}
