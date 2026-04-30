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
    vim.cmd.colorscheme("base16-decaf")
    local set_hl = vim.api.nvim_set_hl
    -----------------------------
    -- BASE COLORSCHEME TWEAKS --
    -----------------------------
    -- set_hl(0, "LineNr", { bg = "#282a2e" })
    set_hl(0, "LineNrAbove", { fg = "#777777" })
    set_hl(0, "LineNrBelow", { fg = "#777777" })
    -- set_hl(0, "CursorLine", { bg = "#1d1f21" })
    -- set_hl(0, "MatchParen", { bg = "#585958" })
    -- set_hl(0, "NormalFloat", { bg = "#232629" })

    -------------------
    -- PLUGINS BELOW --
    -------------------
    -- indent-blankline
    -- set_hl(0, "IndentBlanklineUnfocused", { fg = "#323332" })
    -- set_hl(0, "IndentBlanklineFocused", { fg = "#858886" })
    -- nvim-cmp
    set_hl(0, "PmenuSel", { bg = "#515151", fg = "#90bee1" })
    -- mini.tabline
    -- - `MiniTablineCurrent` - buffer is current (has cursor in it).
    -- - `MiniTablineVisible` - buffer is visible (displayed in some window).
    -- - `MiniTablineHidden` - buffer is hidden (not displayed).
    -- - `MiniTablineModifiedCurrent` - buffer is modified and current.
    -- - `MiniTablineModifiedVisible` - buffer is modified and visible.
    -- - `MiniTablineModifiedHidden` - buffer is modified and hidden.
    -- - `MiniTablineFill` - unused right space of tabline.
    -- - `MiniTablineTabpagesection` - section with tabpage information.
    -- - `MiniTablineTrunc` - truncation symbols indicating more left/right tabs.
    local MiniTablineColors = {
      fg_current = "#cccccc",
      fg_visible = "#777777",
      fg_modified = "#ffd67c",
      bg_current = "#515151",
      bg_visible = "#393939",
      bg_hidden = "#262626",
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
