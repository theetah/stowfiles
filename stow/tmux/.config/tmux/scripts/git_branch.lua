#!/usr/bin/env lua

local cwd = arg[1]
local variant = arg[2]

local function git_branch()
	local success, b = pcall(function()
		local handle = io.popen("git -C " .. cwd .. " rev-parse --abbrev-ref HEAD")
		assert(handle ~= nil)
		local branch = handle:read("*a")
		handle:close()
		return branch:gsub("\n", "") -- remove trailing newline
	end)

	if not success or b == "" then
		return ""
	end

	local output = "@" .. b
	if variant == "unfocused" then
		output = "#[fg=#515151]" .. output .. "#[fg=default]"
	end
	return output
end

io.stdout:write(git_branch())
