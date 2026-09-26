#!/usr/bin/env lua

local cwd = arg[1]
local variant = arg[2]

local states = {
	{
		found = false,
		label = "M",
		color = "#ffd67c",
	},
	{
		found = false,
		label = "?",
		color = "#beda78",
	},
	{
		found = false,
		label = "A",
		color = "#beda78",
	},
	{
		found = false,
		label = "R",
		color = "#ffd67c",
	},
	{
		found = false,
		label = "C",
		color = "#beda78",
	},
	{
		found = false,
		label = "D",
		color = "#ff7f7b",
	},
	{
		found = false,
		label = "T",
		color = "#bed6ff",
	},
}

local contexts = {
	MERGE_CONFLICT = {
		found = false,
		label = "!",
		color = "#ff7f7b",
	},
	STASHED = {
		found = false,
		label = "$",
		color = "#ffbf70",
	},
	STAGED = {
		found = false,
		label = "S",
		color = "#90bee1",
	},
}

local offsets = {
	AHEAD = {
		label = "+",
		color = "#ff93b3",
	},
	BEHIND = {
		label = "-",
		color = "#ff93b3",
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

	local STATUS_SIZE = 10

	table.sort(states, function(a, b)
		return a.label < b.label
	end)

	local output = ""

	if tonumber(ahead) > 0 then
		local c = variant == "unfocused" and "#515151" or offsets.AHEAD.color
		output = output .. "#[fg=" .. c .. "]" .. offsets.AHEAD.label .. ahead .. "#[fg=default]"
	elseif tonumber(behind) > 0 then
		local c = variant == "unfocused" and "#515151" or offsets.BEHIND.color
		output = output .. "#[fg=" .. c .. "]" .. offsets.BEHIND.label .. behind .. "#[fg=default]"
	end

	for _, t in pairs(states) do
		if t.found then
			local c = variant == "unfocused" and "#515151" or t.color
			output = output
				.. "#[fg="
				.. c
				.. "]"
				.. string.sub(t.label, 1, math.floor(STATUS_SIZE / num_statuses))
				.. "#[fg=default]"
		end
	end

	if variant == "unfocused" then
		output = "#[fg=#515151][#[fd=default]" .. output .. "#[fg=#515151]]#[fg=default]"
	else
		output = "[" .. output .. "]"
	end

	output, _ = output:gsub("\n", "")
	return output
end

io.stdout:write(format_status())
