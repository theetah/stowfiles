return {
  "MagicDuck/grug-far.nvim",
  opts = {
    keymaps = {
      close = { n = "<localleader>q" },
    },
  },
  init = function()
    vim.keymap.set("n", "<leader>gf", "<cmd>GrugFar<CR>", { desc = "Grug Far (search & replace)" })
  end,
}
