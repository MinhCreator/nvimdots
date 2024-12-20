-- local pattern = '[^:]+:(%d+):(%d+):(%w+):(.+)'
-- local groups = { 'lnum', 'col', 'code', 'message', "end_col", 'file', 'severity' }
-- local defaults = { ["source"] = "ruff", "pyright" }

-- require('lint').linters.ruff = {
--     cmd = 'ruff_cmd',
--     stdin = true,            -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
--     append_fname = true,     -- Automatically append the file name to `args` if `stdin = false` (default: true)
--     args = {},               -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
--     stream = nil,            -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
--     ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
--     parser = require('lint.parser').from_pattern(pattern, groups, defaults),
-- }
return { --Add linter
    {
        "mfussenegger/nvim-lint",
        lazy = true,
        event = {
            "BufReadPre",
            "BufNewFile",
            "VeryLazy",
        },
        config = function()
            --require("plugins/lsp.formater_and_linter")
            --require("plugins/ui_menu.lualine")
            local lint = require("lint")

            local lint_group = vim.api.nvim_create_augroup("Linter", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_group,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}

