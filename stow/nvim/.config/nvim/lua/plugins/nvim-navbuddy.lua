-- NOTE: the newer maintained version of this plugin doesn't actually work.

return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "numToStr/Comment.nvim",
    "nvim-telescope/telescope.nvim",
    {
      -- For cleanliness this is config'd in another file (`nvim-navic.lua`)
      "SmiteshP/nvim-navic",
      dependencies = {
        "neovim/nvim-lspconfig",
      },
    },
  },

  config = function()
    -- have to set up as config function instead of passing an opts table
    -- because otherwise we can't require the two modules below
    local navbuddy = require("nvim-navbuddy")
    local actions = require("nvim-navbuddy.actions")
    local opts = {
      lsp = { auto_attach = true },
      custom_hl_group = "Visual",
      window = {
        size = { width = "50%", height = "40%" },
        scrolloff = 2,
        sections = {
          left = { size = "20%" },
          mid = { size = "20%" },
          right = { size = "60%", preview = "always" },
        },
        border = "none",
      },
      node_markers = {
        icons = {
          leaf = " ",
          leaf_selected = " ",
          branch = "-> ...",
        },
      },
      icons = {
        Variable = "󰫧 ",
        Boolean = "󰔡 ",
        String = " ",
        Object = "󱥔 ",
        Class = " ",
        Field = " ",
      },
      -- mappings = {
      --   ["/"] = actions.telescope({ -- Fuzzy finder at current level.
      --     layout_config = { -- All options that can be
      --       height = 0.60, -- passed to telescope.nvim's
      --       width = 0.60, -- default can be passed here.
      --       prompt_position = "top",
      --       preview_width = 0.50,
      --     },
      --     layout_strategy = "horizontal",
      --   }),
      -- },
    }
    -- TODO: make this context-aware (i.e., close menu if pressing tab in Navbuddy menu)
    vim.keymap.set("n", "<tab>", function()
      -- not a particularly efficient way, executing this on every invokation. Too bad!
      local cmds = vim.api.nvim_buf_get_commands(0, { builtin = false })
      if cmds["Navbuddy"] then
        vim.api.nvim_cmd({ cmd = "Navbuddy" }, {})
      else
        print("LSP not attached, or Navbuddy not registered to this buffer")
      end
    end)
    -- vim.keymap.set("n", "<tab>", "<cmd>Navbuddy<CR>", { desc = "Open Navbuddy" })
    navbuddy.setup(opts)
  end,
}
