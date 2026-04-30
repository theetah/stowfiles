return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "3rd/image.nvim",
      build = false,
      opts = {
        processor = "magick_cli",
      },
    },
  },
  opts = {
    lang = "java", -- used to be C but memory management is apparently too much for me
    image_support = true,
  },
}
