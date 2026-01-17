return {
  "RRethy/base16-nvim",
  -- name = "catppuccin",
  priority = 1000,
  -- opts = {
  --   overrides = function()
  --     return {
  --       CursorLine = { bg = "#272733" },
  --       TabLineSel = { bg = "#957fb8" },
  --     }
  --   end,
  -- },
  -- opts = {
  --   palette = "tomorrow",
  --   plugins = {
  --     all = true,
  --   },
  -- },
  config = function()
    vim.cmd.colorscheme("base16-tomorrow-night")
    -- base colorscheme tweaks
    -- vim.api.nvim_set_hl(0, "LineNr", { bg = "#282a2e" })
    -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1d1f21" })
    vim.api.nvim_set_hl(0, "MatchParen", { bg = "#585958" })
    -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "#282a2e" })
    -- vim.api.nvim_set_hl(0, "GitGutterAdd", { bg = "#282a2e", fg = "#b5bd68" })
    -- vim.api.nvim_set_hl(0, "GitGutterDelete", { bg = "#282a2e", fg = "#81a2be" })
    -- vim.api.nvim_set_hl(0, "GitGutterChange", { bg = "#282a2e", fg = "#cc6666" })
    -- vim.api.nvim_set_hl(0, "GitGutterChangeDelete", { bg = "#282a2e", fg = "#b294bb" })
    -- NOTE: so... lualine won't unlink the hl groups for command & normal,
    -- even when I declare them within the importing file... why is it designed like this?!
    -- vim.api.nvim_set_hl(0, "lualine_a_command", { fg = "#282a2e", bg = "#f0c674" })

    -------------------
    -- plugins below --
    -------------------
    -- indent-blankline
    vim.api.nvim_set_hl(0, "IndentBlanklineUnfocused", { fg = "#323332" })
    vim.api.nvim_set_hl(0, "IndentBlanklineFocused", { fg = "#858886" })
    -- nvim-cmp
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#323435", fg = "#81a2be" })
    -- mini.tabline
    -- - `MiniTablineCurrent` - buffer is current (has cursor in it). fg=#b5bd68 bg=#282a2e
    -- - `MiniTablineVisible` - buffer is visible (displayed in some window). fg=#b5bd68 bg=#282a2e
    -- - `MiniTablineHidden` - buffer is hidden (not displayed). fg=#969896 bg=#282a2e
    -- - `MiniTablineModifiedCurrent` - buffer is modified and current. fg=#c5c8c6 bg=#373b41
    -- - `MiniTablineModifiedVisible` - buffer is modified and visible. fg=#c5c8c6 bg=#373b41
    -- - `MiniTablineModifiedHidden` - buffer is modified and hidden. fg=#b4b7b4 bg=#282a2e
    -- - `MiniTablineFill` - unused right space of tabline. fg=#c5c8c6 bg=#1d1f21
    -- - `MiniTablineTabpagesection` - section with tabpage information.
    -- - `MiniTablineTrunc` - truncation symbols indicating more left/right tabs.
    vim.api.nvim_set_hl(0, "MiniTablineCurrent", { fg = "#c5c8c6", bg = "#373b41" })
    vim.api.nvim_set_hl(0, "MiniTablineVisible", { link = "MiniTablineCurrent" })
    vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", { fg = "#f0c674", bg = "#373b41" })
    vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", { link = "MiniTablineModifiedCurrent" })
    vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", { fg = "#f0c674", bg = "#282a2e" })
  end,
}
