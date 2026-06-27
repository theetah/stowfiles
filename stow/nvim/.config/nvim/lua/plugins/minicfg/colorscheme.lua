-- General editor colorscheme
require("mini.base16").setup({
  palette = {
    base00 = "#2d2d2d",
    base01 = "#393939",
    base02 = "#515151",
    base03 = "#777777",
    base04 = "#b4b7b4",
    base05 = "#cccccc",
    base06 = "#e0e0e0",
    base07 = "#ffffff",
    base08 = "#ff7f7b",
    base09 = "#ffbf70",
    base0A = "#ffd67c",
    base0B = "#beda78",
    base0C = "#bed6ff",
    base0D = "#90bee1",
    base0E = "#efb3f7",
    base0F = "#ff93b3",
  },
})

local set_hl = vim.api.nvim_set_hl

-------------------------
-- mini.tabline colors --
-------------------------
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
set_hl(0, "MiniTablineHidden", { fg = MiniTablineColors.fg_visible, bg = MiniTablineColors.bg_hidden, italic = true })
set_hl(0, "MiniTablineVisible", { fg = MiniTablineColors.fg_visible, bg = MiniTablineColors.bg_visible })
set_hl(0, "MiniTablineModifiedCurrent", { fg = MiniTablineColors.fg_modified, bg = MiniTablineColors.bg_current })
set_hl(0, "MiniTablineModifiedVisible", { fg = MiniTablineColors.fg_modified, bg = MiniTablineColors.bg_visible })
set_hl(
  0,
  "MiniTablineModifiedHidden",
  { fg = MiniTablineColors.fg_modified, bg = MiniTablineColors.bg_hidden, italic = true }
)

----------------------------
-- mini.statusline colors --
----------------------------
local MiniStatuslineColors = {
  fg_mode = "#2d2d2d",
  mode_bg_colors = {
    Normal = "#90bee1",
    Insert = "#beda78",
    Command = "#ffd67c",
    Visual = "#efb3f7",
    Replace = "#ffbf70",
    Other = "#ff7f7b",
  },
}

for mode, color in pairs(MiniStatuslineColors.mode_bg_colors) do
  set_hl(0, "MiniStatuslineMode" .. mode, { fg = MiniStatuslineColors.fg_mode, bg = color })
end

----------------------------
-- mini.indentscope colors --
----------------------------
-- local MiniIndentscopeColors = {
-- 	fg = "#777777"
-- }
-- set_hl(0, "MiniIndentscopeSymbol", { fg = MiniIndentscopeColors.fg })
-- set_hl(0, "MiniIndentscopeSymbolOff", { fg = MiniIndentscopeColors.fg })
