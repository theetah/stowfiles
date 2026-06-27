-- NOTE: You will find keymaps for plugins in their respective files.
-- Mostly because I can and will forget about their configurations here otherwise.

local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--[[
-- Objectively a terrible keybind.
-- Do not do this. I do not use the
-- 'x' keybind for its intended
-- purpose, nor do I intend to
-- learn to do so.
--]]
map("n", "x", [["_dl]])

-- use <C-\><C-n> to exit terminal mode

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- The existence of this bind is perhaps indicative of a structural problem of vim.
map("n", "<leader>y", "ggVGy`.zz", { desc = "Copy all of the current buffer" })

-- Currently doesn't work, even after tinkering. Thanks tmux!
-- Though, perhaps this is for the better.
-- map("i", "<C-BS>", "<C-w>", { desc = "Alias for Ctrl + w (delete previous word)." })
