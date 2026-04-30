-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", ":Neotree toggle<CR>", desc = "NeoTree reveal", silent = true },
  },
  opts = {
    window = {
      -- width = 20,
    },
    filesystem = {
      -- window = {
      --   mappings = {
      --     ["<leader>e"] = "close_window",
      --   },
      -- },
      filtered_items = {
        hide_dotfiles = false,
      },
    },
  },
}
