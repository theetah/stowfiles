require("mini.cursorword").setup()
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
    highlighters = {
        fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
        hack = { pattern = "HACK", group = "MiniHipatternsHack" },
        todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
        note = { pattern = "NOTE", group = "MiniHipatternsNote" },
        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})
require("mini.trailspace").setup()
-- local MiniIndentScope = require("mini.indentscope")
-- MiniIndentScope.setup({
--   draw = {
--     animation = MiniIndentScope.gen_animation.none(),
--   },
--   symbol = "│",
-- })
