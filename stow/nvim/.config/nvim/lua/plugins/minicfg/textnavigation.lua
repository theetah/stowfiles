require("mini.cursorword").setup()
require("mini.hipatterns").setup({
    highlighters = {
        fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
        hack = { pattern = "HACK", group = "MiniHipatternsHack" },
        todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
        note = { pattern = "NOTE", group = "MiniHipatternsNote" },
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
