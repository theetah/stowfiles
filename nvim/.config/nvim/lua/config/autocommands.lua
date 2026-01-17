-- vim. why do i have to do this. all of this just to check if the commandbar is focused.
local focused = false

vim.api.nvim_create_autocmd("CmdlineEnter", {
  desc = "Tracks when the command line is entered",
  group = vim.api.nvim_create_augroup("cmdline-focus-gained", { clear = true }),
  callback = function()
    focused = true
  end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
  desc = "Tracks when the commandline is left. If not focused for awhile, it will clear itself.",
  group = vim.api.nvim_create_augroup("cmdline-focus-lost", { clear = true }),
  callback = function()
    focused = false
    vim.defer_fn(function()
      if not focused then
        vim.cmd('echom ""')
      end
    end, 10000)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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
    vim.api.nvim_command("EnfInd")
  end,
})
