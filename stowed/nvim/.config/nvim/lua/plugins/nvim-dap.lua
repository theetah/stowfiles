return {
  "jay-babu/mason-nvim-dap.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      {
        "mfussenegger/nvim-dap",
        config = function()
          -- Keymaps
          -- vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle a breakpoint" })
          -- vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue the debugging process" })

          -- Change what nvim-dap uses for its signs
          vim.fn.sign_define("DapBreakpoint", {
            text = "",
            texthl = "DiagnosticSignError",
            linehl = "",
            numhl = "",
          })

          vim.fn.sign_define("DapBreakpointRejected", {
            text = "",
            texthl = "DiagnosticSignError",
            linehl = "",
            numhl = "",
          })

          vim.fn.sign_define("DapStopped", {
            text = "󱕊",
            texthl = "DiagnosticSignWarn",
            linehl = "Visual",
            numhl = "DiagnosticSignWarn",
          })
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup()

          -- Listeners
          dap.listeners.before.attach.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.launch.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
          end
          dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
          end
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = { commented = true },
      },
    },
  },
  opts = { handlers = {} },
}
