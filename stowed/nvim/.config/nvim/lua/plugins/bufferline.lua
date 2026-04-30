return {
  enabled = false,
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<leader>bd", "<cmd>bdelete!<cr>", desc = "Delete the current buffer" },
    { "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "<leader>bml", "<Cmd>BufferLineMoveNext<CR>", desc = "Move current buffer to the right" },
    { "<leader>bmh", "<Cmd>BufferLineMovePrev<CR>", desc = "Move current buffer to the left" },
  },
  opts = {
    options = {
      always_show_bufferline = true,
      -- enforce_regular_tabs = true,
      indicator = {
        style = "underline",
      },
      separator_style = "thin",
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
    highlights = {
      buffer_selected = {
        -- Below line only works for theme implementations like kanagawa.nvim, iirc
        -- sp = vim.g.BufferLineTabSelected, -- WHY is this a global variable?! Shouldn't it be stored in a table?
        italic = false,
      },
    },
  },
  config = function(_, opts)
    vim.opt.termguicolors = true
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
