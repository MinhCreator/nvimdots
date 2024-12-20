require "nvchad.options"
local opt = vim.opt
local g = vim.g
local o = vim.o


opt.encoding = "utf-8"
opt.swapfile = false
opt.wrap = false
opt.termguicolors = true           -- True color support
opt.autoindent = true              --- Good auto indent
opt.backspace = "indent,eol,start" --- Making sure backspace works
opt.smoothscroll = true
o.mousemoveevent = true
vim.opt.sessionoptions = "blank,buffers,curdir,tabpages,winsize,winpos,terminal,localoptions"
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.cursorlineopt = "number"
opt.expandtab = true
opt.smartindent = true
opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.splitbelow = true
opt.splitright = true
opt.foldenable = true
opt.foldcolumn = "auto" -- show foldcolumn in nvim 0.9
opt.foldnestmax = 0
opt.foldlevel = 99
opt.foldlevelstart = 99
vim.opt.fillchars = {
    fold = " ",
    foldopen = "",
    -- foldopen = '◡',
    foldsep = " ",
    foldclose = "",
    -- foldclose = '▹',
    -- foldclose = '◠',
    -- [eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    stl = " ",
    eob = " ",
}
opt.emoji = false
opt.cursorline = true
opt.smoothscroll = true
if vim.fn.has 'win32' == 1 then
    --Add powershell emulator
    opt.shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
    o.shell = "powershell.exe"
    o.shellcmdflag =
    "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"

    o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"

    o.shellquote = ""

    o.shellxquote = ""
end

if g.neovide then
    g.neovide_padding_top = 0
    g.neovide_padding_bottom = 0
    g.neovide_padding_right = 0
    g.neovide_padding_left = 0
    --vim.g.neovide_transparency = 0.8
    g.neovide_transparency = 1
    -- vim.g.neovide_background_color = "#0f1117" .. alpha()
    g.neovide_scroll_animation_length = 0.1
    g.neovide_position_animation_length = 0.1
    g.neovide_cursor_animate_command_line = true
    g.neovide_cursor_trail_size = 0.5
    g.neovide_cursor_animation_length = 0.1
    g.neovide_refresh_rate_idle = 25
    g.neovide_refresh_rate = 60
    g.neovide_theme = "auto"
    g.neovide_hide_mouse_when_typing = false
    g.neovide_line_space = 10
    g.neovide_window_blurred = true
    g.neovide_floating_blur_amount_x = 2.0
    g.neovide_floating_blur_amount_y = 2.0
    g.neovide_floating_shadow = false
    g.neovide_floating_z_height = 10
    g.neovide_light_angle_degrees = 45
    g.neovide_light_radius = 5
    g.neovide_cursor_antialiasing = true
    g.neovide_underline_automatic_scaling = false
    g.neovide_hide_mouse_when_typing = true


    -- See https://github.com/neovide/neovide/issues/2330
    vim.schedule(function()
        vim.cmd "NeovideFocus"
    end)

    -- https://github.com/neovide/neovide/issues/1771
    vim.api.nvim_create_autocmd({ "BufLeave", "BufNew" }, {
        callback = function()
            vim.g.neovide_scroll_animation_length = 0
            vim.g.neovide_cursor_animation_length = 0
        end,
    })

    -- https://github.com/neovide/neovide/issues/1771
    vim.api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
        callback = function()
            vim.fn.timer_start(32, function()
                vim.g.neovide_scroll_animation_length = 0.3
                vim.g.neovide_cursor_animation_length = 0.08
            end)
        end,
    })
end


o.guifont = "JetBrainsMono_NF:h11:#e-subpixelantialias"
--Add font
-- vim.o.set.autochdir = true
-- vim.cmd(":set autochdir")
-- vim.o.guifont = "Hasklug Nerd Font:h12:#e-subpixelantialias"
-- vim.o.guifont = "CaskaydiaCove Nerd Font:h11" --:#e-subpixelantialias"
opt.termguicolors = true
vim.cmd(": set nohidden")
vim.cmd(": set cmdheight=0")
-- vim.cmd(": set autochdir")
-- vim.cmd(":set shell='powershell.exe'")
-- vim.cmd(": set shellcmdflag=-command")
-- vim.cmd.colorscheme("onedark")
-- vim.cmd(":set shellcmdflag='-ExecutionPolicy RemoteSigned -Command'")
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     nested = true,
--     callback = function ()
--       vim.cmd.colorscheme(vim.g.SCHEME)
--     end
-- })

-- vim.api.nvim_create_autocmd({ "Colorscheme" }, {
--   callback = function (params)
--     vim.g.SCHEME = params.match
--   end
-- })
