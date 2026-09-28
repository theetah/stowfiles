#!/usr/bin/env lua

local cwd = arg[1]
local format = arg[2]
local color_override = arg[3]

local states = {
	{
		found = false,
		label = "M",
		color = os.getenv("YELLOW"),
	},
	{
		found = false,
		label = "?",
		color = os.getenv("GREEN"),
	},
	{
		found = false,
		label = "A",
		color = os.getenv("GREEN"),
	},
	{
		found = false,
		label = "R",
		color = os.getenv("YELLOW"),
	},
	{
		found = false,
		label = "C",
		color = os.getenv("GREEN"),
	},
	{
		found = false,
		label = "D",
		color = os.getenv("RED"),
	},
	{
		found = false,
		label = "T",
		color = os.getenv("CYAN"),
	},
}

local contexts = {
	MERGE_CONFLICT = {
		found = false,
		label = "!",
		color = os.getenv("RED"),
	},
	STASHED = {
		found = false,
		label = "$",
		color = os.getenv("ORANGE"),
	},
	STAGED = {
		found = false,
		label = "S",
		color = os.getenv("BLUE"),
	},
}

local offsets = {
	AHEAD = {
		label = "+",
		color = os.getenv("MAGENTA"),
	},
	BEHIND = {
		label = "-",
		color = os.getenv("MAGENTA"),
	},
}

-- 1. if there is a U in a row, or a row is AA, merge conflict
-- 2. if anything else in left column, simply indicate staged
-- 3. if not either above, treat as normal

local function format_status()
	local success, git_status, stash_exists, ahead, behind = pcall(function()
		-- `-C` arg allows us to execute git in a different path as if it was the cwd.
		-- status
		local handle = io.popen("git -C " .. cwd .. " status --porcelain")
		assert(handle ~= nil)
		local status = handle:read("*a")
		handle:close()

		-- stash
		handle = io.popen("git -C " .. cwd .. " stash list")
		assert(handle ~= nil)
		local stash = handle:read("*a")
		handle:close()

		-- ahead
		handle = io.popen("git -C " .. cwd .. " rev-list --count @{u}..HEAD")
		assert(handle ~= nil)
		local a = handle:read("*a")
		handle:close()

		-- behind
		handle = io.popen("git -C " .. cwd .. " rev-list --count HEAD..@{u}")
		assert(handle ~= nil)
		local b = handle:read("*a")
		handle:close()

		return status, stash, a, b
	end)

	if not success or (git_status == "" and stash_exists == "" and tonumber(ahead) == 0 and tonumber(behind) == 0) then
		return ""
	end

	local lines = {}

	for match in string.gmatch(git_status, "([^\n]+)") do
		table.insert(lines, string.sub(match, 1, 2))
	end

	if string.len(stash_exists) > 0 then
		contexts.STASHED.found = true
	end

	for _, v in pairs(lines) do
		if string.find(v, "U") or v == "AA" then
			contexts.MERGE_CONFLICT.found = true
		elseif string.sub(v, 1, 1) ~= " " and string.sub(v, 1, 1) ~= "?" then
			contexts.STAGED.found = true
		else
			for _, t in ipairs(states) do
				if string.find(v, t.label) then
					t.found = true
				end
			end
		end
	end

	for _, v in pairs(contexts) do
		table.insert(states, v)
	end

	local num_statuses = 0
	for _, t in ipairs(states) do
		if t.found then
			num_statuses = num_statuses + 1
		end
	end

	table.sort(states, function(a, b)
		return a.label < b.label
	end)

	local output = ""
	local STATUS_SIZE = 10

	if tonumber(ahead) > 0 then
		if color_override ~= nil then
			output = output .. offsets.AHEAD.label .. ahead
		else
			output = output .. "#[fg=" .. offsets.AHEAD.color .. "]" .. offsets.AHEAD.label .. ahead .. "#[fg=default]"
		end
	elseif tonumber(behind) > 0 then
		if color_override ~= nil then
			output = output .. offsets.BEHIND.label .. behind
		else
			output = output
				.. "#[fg="
				.. offsets.BEHIND.color
				.. "]"
				.. offsets.BEHIND.label
				.. behind
				.. "#[fg=default]"
		end
	end

	for _, t in pairs(states) do
		if t.found then
			if color_override ~= nil then
				output = output .. string.sub(t.label, 1, math.floor(STATUS_SIZE / num_statuses))
			else
				output = output
					.. "#[fg="
					.. t.color
					.. "]"
					.. string.sub(t.label, 1, math.floor(STATUS_SIZE / num_statuses))
					.. "#[fg=default]"
			end
		end
	end

	-- remove newlines, and format string if specified
	output, _ = (format ~= nil and string.format(format, output) or output):gsub("\n", "")
	if color_override ~= nil then
		output = "#[fg=" .. color_override .. "]" .. output .. "#[fg=default]"
	end

	return output
end

io.stdout:write(format_status())
