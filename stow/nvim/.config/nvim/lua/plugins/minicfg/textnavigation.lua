require("mini.cursorword").setup()
require("mini.hipatterns").setup()
require("mini.trailspace").setup()
local MiniIndentScope = require("mini.indentscope")
MiniIndentScope.setup({
  draw = {
    animation = MiniIndentScope.gen_animation.none(),
  },
})
