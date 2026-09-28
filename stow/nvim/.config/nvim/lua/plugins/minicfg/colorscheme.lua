-- General editor colorscheme
local palette = {
    base00 = "#242424",
    base01 = "#2e2e2e",
    base02 = "#474747",
    base03 = "#676767",
    base04 = "#b4b4b4",
    base05 = "#cccccc",
    base06 = "#e0e0e0",
    base07 = "#ffffff",
    base08 = "#ff7f7b",
    base09 = "#ffb961",
    base0A = "#ffd67c",
    base0B = "#beda78",
    base0C = "#a1e6e0",
    base0D = "#90bee1",
    base0E = "#efb3f7",
    base0F = "#ff93b3",
}

require("mini.base16").setup({
    palette = palette,
})

local set_hl = vim.api.nvim_set_hl
local get_hl = vim.api.nvim_get_hl

-------------------------
-- mini.tabline colors --
-------------------------
local MiniTablineColors = {
    fg_current = palette.base05,
    fg_visible = palette.base03,
    fg_modified = palette.base0A,
    bg_current = palette.base02,
    bg_visible = palette.base01,
    bg_hidden = palette.base00,
}
set_hl(0, "MiniTablineCurrent", {
    fg = MiniTablineColors.fg_current,
    bg = MiniTablineColors.bg_current,
})
set_hl(0, "MiniTablineHidden", { fg = MiniTablineColors.fg_visible, bg = MiniTablineColors.bg_hidden })
set_hl(0, "MiniTablineVisible", { fg = MiniTablineColors.fg_visible, bg = MiniTablineColors.bg_visible })
set_hl(
    0,
    "MiniTablineModifiedCurrent",
    { fg = MiniTablineColors.fg_modified, bg = MiniTablineColors.bg_current, italic = true }
)
set_hl(
    0,
    "MiniTablineModifiedVisible",
    { fg = MiniTablineColors.fg_modified, bg = MiniTablineColors.bg_visible, italic = true }
)
set_hl(
    0,
    "MiniTablineModifiedHidden",
    { fg = MiniTablineColors.fg_modified, bg = MiniTablineColors.bg_hidden, italic = true }
)

----------------------------
-- mini.statusline colors --
----------------------------
-- more fine-grained control for components' colors are stored in the statusline's config file.
local MiniStatuslineColors = {
    fg_mode = palette.base00,
    mode_bg_colors = {
        Normal = palette.base0D,
        Insert = palette.base0B,
        Command = palette.base0A,
        Visual = palette.base0E,
        Replace = palette.base09,
        Other = palette.base08,
    },
}

for mode, color in pairs(MiniStatuslineColors.mode_bg_colors) do
    set_hl(0, "MiniStatuslineMode" .. mode, { fg = MiniStatuslineColors.fg_mode, bg = color })
end

-----------------------------
-- mini.indentscope colors --
-----------------------------
-- local MiniIndentscopeColors = {
-- 	fg = "#777777"
-- }
-- set_hl(0, "MiniIndentscopeSymbol", { fg = MiniIndentscopeColors.fg })
-- set_hl(0, "MiniIndentscopeSymbolOff", { fg = MiniIndentscopeColors.fg })

-----------------------------
-- indent-blankline colors --
-----------------------------

set_hl(0, "CustomIndentBlanklineIndent", { fg = palette.base03, bg = "NONE" })
set_hl(0, "CustomIndentBlanklineScope", { fg = palette.base04, bg = "NONE" })
