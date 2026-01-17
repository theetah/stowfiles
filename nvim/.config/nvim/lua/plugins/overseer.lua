return {
  "stevearc/overseer.nvim",
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {},
  dependencies = { "leath-dub/snipe.nvim" },
  init = function()
    local menu = require("snipe.menu"):new({ position = "center" })
    local function set_keymaps(m)
      vim.keymap.set("n", "<esc>", function()
        m:close()
      end, { nowait = true, buffer = m.buf })
    end

    menu:add_new_buffer_callback(set_keymaps)

    vim.keymap.set("n", "<leader>o", function()
      local items = {
        -- "Open",
        -- "Close",
        "Run",
        "Toggle",
        "TaskAction",
        "Shell",
      }
      menu.config.open_win_override.title = "Overseer Commands"
      menu:open(items, function(m, i)
        m:close()
        -- print("running " .. m.items[i])
        vim.cmd("Overseer" .. m.items[i])
        -- vim.api.nvim_set_current_buf(m.items[i].id)
      end, function(item)
        return item
      end)
    end)
  end,
}
