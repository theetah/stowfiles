return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "pogyomo/submode.nvim", "SmiteshP/nvim-navic" },
  config = function()
    local lualine = require("lualine")
    local submode = require("submode")

    -- local left_separator = ""
    -- local right_separator = ""
    local left_separator = ""
    local right_separator = ""

    local function get_submode()
      local m = submode.mode()
      if m then
        return string.upper(m)
      else
        return nil
      end
    end

    local debug_indicator = {
      function()
        return "DEBUGGING"
      end,
      -- INCREDIBLY hacky way to set a highlight group color to hexadecimal format, as it normally returns in decimal.
      -- what the hell? why does it return decimal?!
      color = { fg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg) },
      cond = function()
        return get_submode() == "DEBUG"
      end,
      right_padding = 0,
      left_padding = 0,
    }

    local opts = {
      options = {
        component_separators = "",
        section_separators = { left = left_separator, right = right_separator },
        disabled_filetypes = { "neo-tree", "trouble", "aerial" },
      },
      sections = {

        lualine_a = {
          {
            "mode",
            fmt = function(s)
              return string.sub(get_submode() or s, 1, 1)
            end,
            -- Unfortunately, color cannot be dynamically changed during runtime.
            separator = { left = left_separator, right = right_separator },
            right_padding = 2,
          },
        },

        lualine_b = {
          "filename",
        },
        lualine_c = { "filetype", "encoding" },

        lualine_x = {
          debug_indicator,
        },

        lualine_y = {
          "diagnostics",
          "lsp_status",
        },

        lualine_z = {
          "branch",
          "progress",
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = { "filename" },
        lualine_c = { "filetype", "encoding" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "branch", "progress" },
      },
      tabline = {},
      extensions = { "trouble", "nvim-dap-ui", "lazy", "neo-tree", "toggleterm" },
    }

    -- Allow submode events to update the statusline
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("user-event", {}),
      pattern = { "SubmodeEnterPre", "SubmodeEnterPost", "SubmodeLeavePre", "SubmodeLeavePost" },
      -- unused arg is `event`.
      callback = function(_)
        lualine.refresh({ place = { "statusline" } })
      end,
    })

    lualine.setup(opts)
  end,
}
