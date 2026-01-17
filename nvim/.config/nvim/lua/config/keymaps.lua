vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--[[
-- Objectively a terrible keybind.
-- Do not do this. I do not use the
-- 'x' keybind for its intended
-- purpose, nor do I intend to
-- learn to do so.
--]]
vim.keymap.set("n", "x", [["_dl]])

-- use <C-\><C-n> to exit terminal mode

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Alias for Ctrl + w (delete previous word)." })
