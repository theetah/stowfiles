vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Attempt to hook in jdtls runtime.
-- FIXME: does not currently work. figure out how this is supposed to be organized at some point
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        require("config.jdtls"):setup()
    end,
})

-- Fix annoying vim-sleuth glitchiness in leetcode.nvim
vim.api.nvim_create_autocmd("FileType", {
    pattern = "leetcode.nvim",
    callback = function()
        -- EnfInd is defined in options.lua
        vim.api.nvim_command("EnfInd")
    end,
})

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil)
    end,
})

-- Place cursor at the last position it was in a given file
-- Shamelessly stolen from https://www.youtube.com/watch?v=v36vLiFVOXY
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            -- defer centering slightly so it's applied after the rendering
            vim.schedule(function()
                vim.cmd("normal! zz")
            end)
        end
    end,
})

-- Also shamelessly stolen from https://www.youtube.com/watch?v=v36vLiFVOXY
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("no_auto_comment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})
