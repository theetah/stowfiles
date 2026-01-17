return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "pogyomo/submode.nvim" },
  config = function()
    local lualine = require("lualine")
    local submode = require("submode")
    -- credit to shadmansaleh and glepnir for this lsp snippet, straight from evil_lualine
    local icon_inactive = "󰲜  "
    local icon_active = "󰱔  "
    local lsp = {
      function()
        local msg = "No LSP Active"
        local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return icon_inactive .. msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return icon_active .. client.name
          end
        end
        return icon_inactive .. msg
      end,
    }

    local navic = { "navic", color_correction = "dynamic", navic_opts = { highlight = true } }
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

    local debug_status = {
      function()
        return "󰃤"
      end,
      color = { fg = "#ff5d62" },
      cond = function()
        return get_submode() == "DEBUG"
      end,
    }

    local opts = {
      options = {
        component_separators = "",
        section_separators = { left = left_separator, right = right_separator },
        -- disabled_filetypes = { "neo-tree", "trouble", "aerial", },
      },
      sections = {

        lualine_a = {
          {
            "mode",
            fmt = function(s)
              return get_submode() or s
            end,
            -- Unfortunately, color cannot be dynamically changed during runtime.
            separator = { left = left_separator, right = right_separator },
            right_padding = 2,
          },
        },

        lualine_b = { debug_status, "filename" },
        lualine_c = { navic },

        lualine_x = {
          "filetype",
        },

        lualine_y = {
          "diagnostics",
          "lsp_status",
          -- lsp,
        },

        lualine_z = {
          "branch",
          { "progress", separator = { left = left_separator, right = right_separator }, left_padding = 2 },
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = { "filename" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "branch", "progress" },
      },
      tabline = {},
      extensions = { "trouble", "nvim-dap-ui", "lazy", "neo-tree", "toggleterm" },
    }

    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("user-event", {}),
      pattern = { "SubmodeEnterPre", "SubmodeEnterPost", "SubmodeLeavePre", "SubmodeLeavePost" },
      callback = function(env)
        lualine.refresh({ place = { "statusline" } })
      end,
    })

    lualine.setup(opts)
  end,
}
