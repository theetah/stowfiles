return {
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
}
