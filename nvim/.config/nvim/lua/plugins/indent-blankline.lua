return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = { highlight = { "IndentBlanklineUnfocused" } },
    scope = { highlight = { "IndentBlanklineFocused" } },
  },
  -- config = function()
  --   -- Kind of messy but it works
  --   local hooks = require("ibl.hooks")
  --   hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  --     vim.api.nvim_set_hl(0, "IndentBlanklineUnfocused", { fg = "#4b4d4b" })
  --     vim.api.nvim_set_hl(0, "IndentBlanklineFocused", { fg = "#858886" })
  --   end)
  --   require("ibl").setup({
  --     indent = { highlight = { "IndentBlanklineUnfocused" } },
  --     scope = { highlight = { "IndentBlanklineFocused" } },
  --   })
  -- end,
}
