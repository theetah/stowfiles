vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Attempt to hook in jdtls runtime.
-- note to self: fix the server directory, at some point...
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
