local utils = require("utils")
utils.require_dir_from_config("lua/core") -- Core configuration, like keymaps, etc.
utils.require_dir_from_config("lua/custom") -- Custom user configuration, i.e. jdtls setup, or Godot setup

-- this line gives Command mode highlighting, and puts startup errors into
-- a buffer that can be accessed with `<g`.
require("vim._core.ui2").enable()

-- Bootstrap lazy.nvim
-- See :help lazy.nvim.txt for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = { { import = "plugins" } },
	change_detection = { enabled = false, notify = false },
})
