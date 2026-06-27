return {
  "pogyomo/submode.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  lazy = true,
  version = "6.0.0",
  init = function()
    local submode = require("submode")

    ----------------------
    ---- DAP & DAP UI ----
    ----------------------
    local dap = require("dap")
    local dapui = require("dapui")
    local dapvt = require("nvim-dap-virtual-text.virtual_text")
    submode.create("Debug", {
      mode = "n",
      enter = "<M-d>",
      leave = { "<ESC>", "<M-d>" },
    })
    submode.set("Debug", "b", dap.toggle_breakpoint, { desc = "Toggle a breakpoint" })
    submode.set("Debug", "c", dap.continue, { desc = "Start/Continue the debugging process" })
    submode.set("Debug", "B", dap.clear_breakpoints, { desc = "Clear all breakpoints" })
    submode.set("Debug", "S", function()
      dap.close()
      dap.clear_breakpoints()
      dapui.close()
      dapvt.clear_virtual_text()
      vim.api.nvim_input("<ESC>")
      print("Aborted debugging process.")
    end, { desc = "Stop the debugging process, clear all breakpoints, and close all DAP UI windows" })
    submode.set("Debug", "w", function()
      local winid = vim.fn.bufwinid(dapui.elements.watches.buffer())
      if winid then
        vim.api.nvim_set_current_win(vim.fn.bufwinid(dapui.elements.watches.buffer()))
        vim.cmd("startinsert")
      else
        print("No watches window was found.")
      end
    end, { desc = "Focus the watches buffer and input a new watch variable, if it exists" })
    submode.set("Debug", "<Left>", dap.step_back, { desc = "Debug: step back" })
    submode.set("Debug", "<Right>", dap.step_over, { desc = "Debug: step over" })
    submode.set("Debug", "<Up>", dap.step_out, { desc = "Debug: step out" })
    submode.set("Debug", "<Down>", dap.step_into, { desc = "Debug: step into" })
    ----------------------
  end,
  config = function()
    -- Allow submode events to update the statusline
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("user-event", {}),
      pattern = { "SubmodeEnterPre", "SubmodeEnterPost", "SubmodeLeavePre", "SubmodeLeavePost" },
      -- unused arg is `event`.
      callback = function(_)
        vim.cmd("redrawstatus")
        -- Use below line instead of the above one for lualine.
        -- lualine.refresh({ place = { "statusline" } })
      end,
    })
  end,
}
