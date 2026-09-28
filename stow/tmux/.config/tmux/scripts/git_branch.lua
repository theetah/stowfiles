#!/usr/bin/env lua

local cwd = arg[1]
local format = arg[2]
local color_override = arg[3]

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

	local output = b

	if format ~= nil then
		output = string.format(format, b)
	end

	if color_override ~= nil then
		output = "#[fg=" .. color_override .. "]" .. output .. "#[fg=default]"
	end

	return output
end

io.stdout:write(git_branch())
