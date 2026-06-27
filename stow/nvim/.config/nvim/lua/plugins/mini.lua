return {
  "nvim-mini/mini.nvim",
  priority = 1000,
  config = function()
    -- Perform witchcraft to require all files in minicfg
    local utils = require("utils")
    ---@diagnostic disable-next-line: undefined-field
    utils.require_dir_from_config("lua/plugins/minicfg")
  end,
}
