return {
  "stevearc/overseer.nvim",
  lazy = false,
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {},
  init = function()
    vim.keymap.set("n", "<leader>o", "<cmd>OverseerToggle<cr>", { desc = "Toggle Overseer" })
    -- This is an awful implementation; I wanted to have all the available commands + Task Action listed...
    vim.keymap.set("n", "<leader>r", function()
      vim.ui.select({ "Run", "Action" }, {
        prompt = "Overseer",
        format_item = function(item)
          return item
        end,
      }, function(choice, _)
        if choice == "Run" then
          vim.api.nvim_command("OverseerRun")
        elseif choice == "Action" then
          vim.api.nvim_command("OverseerTaskAction")
        end
      end)
    end, { desc = "Run an Overseer Command" })
  end,
}
