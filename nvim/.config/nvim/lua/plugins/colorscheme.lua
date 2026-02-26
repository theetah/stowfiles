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
    local set_hl = vim.api.nvim_set_hl
    -- base colorscheme tweaks
    -- set_hl(0, "LineNr", { bg = "#282a2e" })
    -- set_hl(0, "CursorLine", { bg = "#1d1f21" })
    set_hl(0, "MatchParen", { bg = "#585958" })
    set_hl(0, "NormalFloat", { bg = "#232629" })
    -- set_hl(0, "SignColumn", { bg = "#282a2e" })
    -- set_hl(0, "GitGutterAdd", { bg = "#282a2e", fg = "#b5bd68" })
    -- set_hl(0, "GitGutterDelete", { bg = "#282a2e", fg = "#81a2be" })
    -- set_hl(0, "GitGutterChange", { bg = "#282a2e", fg = "#cc6666" })
    -- set_hl(0, "GitGutterChangeDelete", { bg = "#282a2e", fg = "#b294bb" })
    -- NOTE: so... lualine won't unlink the hl groups for command & normal,
    -- even when I declare them within the importing file... why is it designed like this?!
    -- set_hl(0, "lualine_a_command", { fg = "#282a2e", bg = "#f0c674" })

    -------------------
    -- plugins below --
    -------------------
    -- indent-blankline
    set_hl(0, "IndentBlanklineUnfocused", { fg = "#323332" })
    set_hl(0, "IndentBlanklineFocused", { fg = "#858886" })
    -- nvim-cmp
    set_hl(0, "PmenuSel", { bg = "#323435", fg = "#81a2be" })
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
    local MiniTablineColors = {
      fg_current = "#c5c8c6",
      fg_visible = "#969896",
      fg_modified = "#f0c674",
      bg_current = "#373b41",
      bg_visible = "#282a2e",
      bg_hidden = "#17191a",
    }
    set_hl(0, "MiniTablineCurrent", {
      fg = MiniTablineColors.fg_current,
      bg = MiniTablineColors.bg_current,
    })
    set_hl(
      0,
      "MiniTablineHidden",
      { fg = MiniTablineColors.fg_visible, bg = MiniTablineColors.bg_hidden, italic = true }
    )
    set_hl(0, "MiniTablineVisible", { fg = MiniTablineColors.fg_visible, bg = MiniTablineColors.bg_visible })
    set_hl(0, "MiniTablineModifiedCurrent", { fg = MiniTablineColors.fg_modified, bg = MiniTablineColors.bg_current })
    set_hl(0, "MiniTablineModifiedVisible", { fg = MiniTablineColors.fg_modified, bg = MiniTablineColors.bg_visible })
    set_hl(
      0,
      "MiniTablineModifiedHidden",
      { fg = MiniTablineColors.fg_modified, bg = MiniTablineColors.bg_hidden, italic = true }
    )
  end,
}
