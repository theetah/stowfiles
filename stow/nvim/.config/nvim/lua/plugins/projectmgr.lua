return {
  "charludo/projectmgr.nvim",
  lazy = false,
  init = function()
    vim.keymap.set("n", "<leader>fp", "<cmd>ProjectMgr<CR>", { desc = "Open Project Manager" })
  end,
}
