-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--vim.cmd("TwilightEnable")

local stats = require("lazy").stats()
local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
local msg = "⚡ Plugins loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"

-- add startup notify
-- vim.notify(msg, "warn", { title = " Plugins Manager " })
vim.fn.timer_start(math.floor(ms), function()
    vim.notify(" Welcome to Neovim", "info", { title = "Neovim" })
    vim.fn.timer_start(math.floor(ms), function()
        vim.notify(" Happy coding!", "info", { title = "Neovim" })
    end)
end)
-- auto move {HomeDir}
vim.cmd(": cd ~/ ")

-- vim.cmd(":set autodir")
local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
    callback = function(args)
        local file = vim.api.nvim_buf_get_name(args.buf)
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

        if not vim.g.ui_entered and args.event == "UIEnter" then
            vim.g.ui_entered = true
        end

        if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
            vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
            vim.api.nvim_del_augroup_by_name "NvFilePost"

            vim.schedule(function()
                vim.api.nvim_exec_autocmds("FileType", {})

                if vim.g.editorconfig then
                    require("editorconfig").config(args.buf)
                end
            end)
        end
    end,
})
local ft = vim.bo.filetype
local cmd = vim.cmd("set filetype?")


-- Auto install treesitter when opening a new file or opening exist file
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', "BufEnter" }, {
    callback = function()
        vim.cmd("TSInstall " .. ft)
    end
})
