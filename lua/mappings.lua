require "nvchad.mappings"
local opts = { noremap = true, silent = true, buffer = 0 }
local map = vim.keymap.set
-- add yours here


map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")


local function handle_copy()
    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" or mode == "" then
        if vim.fn.line "'<" == vim.fn.line "'>" and vim.fn.col "'<" == vim.fn.col "'>" then
            vim.cmd.normal '"+yy'
        else
            vim.cmd.normal '"+y'
        end
    else
        vim.cmd.normal '"+yy'
    end
end

local function handle_paste()
    vim.cmd.normal '"+p'
end

local function md_url_paste()
    -- Get clipboard
    local clip = vim.fn.getreg "+"
    -- 0-indexed locations
    local start_line = vim.fn.getpos("v")[2] - 1
    local start_col = vim.fn.getpos("v")[3] - 1
    local stop_line = vim.fn.getcurpos("")[2] - 1
    local stop_col = vim.fn.getcurpos("")[3] - 1
    -- Check start and stop aren't reversed, and swap if necessary
    if stop_line < start_line or (stop_line == start_line and stop_col < start_col) then
        start_line, start_col, stop_line, stop_col = stop_line, stop_col, start_line, start_col
    end
    -- Paste clipboard contents as md link.
    vim.api.nvim_buf_set_text(0, stop_line, stop_col + 1, stop_line, stop_col + 1, { "](" .. clip .. ")" })
    vim.api.nvim_buf_set_text(0, start_line, start_col, start_line, start_col, { "[" })
end

-- Move or create
---@param key 'h'|'j'|'k'|'l'
local function move_or_create_win(key)
    local fn = vim.fn
    local curr_win = fn.winnr()
    vim.cmd("wincmd " .. key)    --> attempt to move

    if curr_win == fn.winnr() then --> didn't move, so create a split
        if key == "h" or key == "l" then
            vim.cmd "wincmd v"
        else
            vim.cmd "wincmd s"
        end

        vim.cmd("wincmd " .. key)
    end
end

local function find_files()
    local entry_maker = require("configs.entry").find_files_entry_maker
    local opts = {
        entry_maker = entry_maker(),
        sorting_strategy = "ascending",
        layout_strategy = "center",
        prompt_title = "Find Files",
        border = true,
        borderchars = {
            prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        layout_config = {
            width = 0.8,
            height = 0.6,
        },
        results_title = false,
        previewer = false,
    }

    opts.show_untracked = true

    local succ = pcall(require("telescope.builtin").git_files, opts)

    if not succ then
        require("telescope.builtin").find_files(opts)
    end
end

--NvMenu
local menu = {
    {
        name = "Format Buffer",
        cmd = function()
            local ok, conform = pcall(require, "conform")

            if ok then
                conform.format { lsp_fallback = true }
            else
                vim.lsp.buf.format()
            end
        end,
        rtxt = "<leader>fm",
    },
    {
        name = "Copy Content",
        cmd = "%y+",
        rtxt = "<C-c>",
    },
    {
        name = "Delete Content",
        cmd = "%d",
        rtxt = "dc",
    },
    {
        name = "  Copy",
        cmd = handle_copy,
    },
    {
        name = "  Paste",
        cmd = handle_paste,
    },
    { name = "separator" },
    {
        name = " Lsp Actions",
        hl = "Exblue",
        items = "lsp",
    },
    { name = "separator" },

    { name = "separator" },
    
}
map("n", "<C-t>", function()
    require("menu").open(menu)
end, { desc = "Open NvChad menu" })

map("n", "<RightMouse>", function()
    vim.cmd.exec '"normal! \\<RightMouse>"'
    local options = vim.bo.ft == "NvimTree" and "nvimtree" or menu
    require("menu").open(options, { mouse = true })
end, { desc = "Open NvChad menu" })

map({ "n", "i", "v" }, "<C-p>", function()
    find_files()
end, { desc = "  Find files" })

map("v", "<leader>p", function()
    md_url_paste()
end, opts)

map("n", "<leader>pp", function()
    md_url_paste()
end, { desc = "Paste in URL" })

map({ "n", "t" }, "<A-g>", function()
    require("nvchad.term").toggle {
        cmd = "lazygit",
        pos = "float",
        id = "gitToggleTerm",
        float_opts = {
            width = 1,
            height = 1,
        },
        clear_cmd = true,
    }
end, { desc = "Toggle Lazygit" })

map("n", "<leader>th", function()
    require("nvchad.themes").open { style = "flat" }
end, { desc = "Open NvChad theme selector" })

map("n", "<leader>q", "<CMD>q<CR>", { desc = "󰗼 Close" })
map("n", "<leader>qq", "<<CMD>qa!<CR>", { desc = "󰗼 Exit" })

-- NvimTree
map({ "n" }, "<C-S-e>", "<cmd> NvimTreeToggle <CR>", { desc = "󰔱 Toggle nvimtree" })
map({ "n", "i" }, "<C-b>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })

-- Replaces the current word with the same word in uppercase, globally
map(
    "n",
    "<leader>sU",
    [[:%s/\<<C-r><C-w>\>/<C-r>=toupper(expand('<cword>'))<CR>/gI<Left><Left><Left>]],
    { desc = "Replace current word with UPPERCASE" }
)

-- Replaces the current word with the same word in lowercase, globally
map(
    "n",
    "<leader>sL",
    [[:%s/\<<C-r><C-w>\>/<C-r>=tolower(expand('<cword>'))<CR>/gI<Left><Left><Left>]],
    { desc = "Replace current word lowercase" }
)

-- Surround
map("x", "'", [[:s/\%V\(.*\)\%V/'\1'/ <CR>]], { desc = "Surround selection with '" })
map("x", '"', [[:s/\%V\(.*\)\%V/"\1"/ <CR>]], { desc = 'Surround selection with "' })
map("x", "*", [[:s/\%V\(.*\)\%V/*\1*/ <CR>]], { desc = "Surround selection with *" })

map("n", "<leader>s*", [[:s/\<<C-r><C-w>\>/*<C-r><C-w>\*/ <CR>]], { desc = "Surround word with *" })
map("n", '<leader>s"', [[:s/\<<C-r><C-w>\>/"<C-r><C-w>\"/ <CR>]], { desc = 'Surround word with "' })
map("n", "<leader>s'", [[:s/\<<C-r><C-w>\>/'<C-r><C-w>\'/ <CR>]], { desc = "Surround word with '" })

map({ "n", "i" }, "<C-h>", function()
    move_or_create_win "h"
end, { desc = "Split left" })
map({ "n", "i" }, "<C-l>", function()
    move_or_create_win "l"
end, { desc = "Split right" })
map({ "n", "i" }, "<C-k>", function()
    move_or_create_win "k"
end, { desc = "Split up" })
map({ "n", "i" }, "<C-j>", function()
    move_or_create_win "j"
end, { desc = "Split down" })
