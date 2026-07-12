return {
  "stevearc/overseer.nvim",
  lazy = false,
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {
    task_list = {
      keymaps = {
        ["i"] = "<cmd>OverseerRun<cr>",
      },
    },
  },
  init = function()
    -- Keymaps
    vim.keymap.set("n", "<leader>o", "<cmd>OverseerToggle<cr>", { desc = "Toggle Overseer" })
  end,
}
