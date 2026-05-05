-- NOTE: the newer maintained version of this plugin doesn't actually work.

return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "numToStr/Comment.nvim",
    "nvim-telescope/telescope.nvim",
    {
      "SmiteshP/nvim-navic",
      dependencies = {
        "neovim/nvim-lspconfig",
      },
      opts = {
        highlight = true,
        lsp = { auto_attach = true },
        icons = {
          Variable = " ",
          Boolean = " ",
          Object = " ",
          Class = " ",
          Field = " ",
        },
        separator = "   ",
      },
      -- init = function()
      --   vim.o.winbar = "%{%luaeval('vim.fs.basename(vim.api.nvim_buf_get_name(0))')%}"
      --     .. (("%{%v:lua.require'nvim-navic'.get_location()%}" ~= "") and "   " or "")
      --     .. (true and "%{%v:lua.require'nvim-navic'.get_location()%}" or "")
      -- end,
    },
  },

  config = function()
    -- have to set up as config function instead of passing an opts table
    -- because otherwise we can't require the two modules below
    local navbuddy = require("nvim-navbuddy")
    local actions = require("nvim-navbuddy.actions")
    local opts = {
      lsp = { auto_attach = true },
      window = {
        size = { width = "75%", height = "40%" },
        scrolloff = 2,
      },
      icons = {
        Variable = " ",
        Boolean = " ",
        String = " ",
        Object = " ",
        Class = " ",
        Field = " ",
      },
      mappings = {
        ["/"] = actions.telescope({ -- Fuzzy finder at current level.
          layout_config = { -- All options that can be
            height = 0.60, -- passed to telescope.nvim's
            width = 0.60, -- default can be passed here.
            prompt_position = "top",
            preview_width = 0.50,
          },
          layout_strategy = "horizontal",
        }),
      },
    }
    -- TODO: make this context-aware (i.e., close menu if pressing tab in Navbuddy menu)
    vim.keymap.set("n", "<tab>", "<cmd>Navbuddy<CR>", { desc = "Open Navbuddy" })
    navbuddy.setup(opts)
  end,
}
