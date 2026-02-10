return {
  "stevearc/overseer.nvim",
  lazy = false,
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {},
  init = function()
    --[[
    -- TODO: replace Snipe with a more "command palette"-esque approach using Telescope/base implementation
    -- FIRST IDEA:
    --    Space+rt -> "Run Task". Might also be Ctrl+Shift+p. Will open the :OverseerRun Menu.
    --    Space+o  -> "Toggle Overseer". Self-explanatory, though we might need an additional keybind for TaskAction.
    -- SECOND IDEA:
    --    Ctrl+Shift+p -> Open (telescope?) menu to select TaskAction or Run Task.
    --        Add additional commands in the future? (would likely require custom directory)
    --    Space+o      -> "Toggle Overseer". Self-explanatory.
    --]]

    vim.keymap.set("n", "<leader>o", "<cmd>OverseerToggle<cr>", { desc = "Toggle Overseer" })

    -- TODO: probably implement using this shit
    --[[
        vim.ui.select({ "tabs", "spaces" }, {
          prompt = "Select tabs or spaces:",
          format_item = function(item)
            return "I'd like to choose " .. item
          end,
        }, function(choice)
          if choice == "spaces" then
            vim.o.expandtab = true
          else
            vim.o.expandtab = false
          end
        end)
    ]]

    -- This is an awful implementation; I wanted to have all the available commands + Task Action listed...
    vim.keymap.set("n", "<leader>p", function()
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
