#!/usr/bin/env lua

local cwd = arg[1]

local data = {
	chars = {
		M = {
			found = false,
			label = "M",
			color = "#ffd67c",
		},
		["?"] = {
			found = false,
			label = "?",
			color = "#beda78",
		},
		A = {
			found = false,
			label = "A",
			color = "#beda78",
		},
		R = {
			found = false,
			label = "R",
			color = "#ffd67c",
		},
		C = {
			found = false,
			label = "C",
			color = "#beda78",
		},
		D = {
			found = false,
			label = "D",
			color = "#ff7f7b",
		},
		T = {
			found = false,
			label = "T",
			color = "#bed6ff",
		},
	},
	switches = {
		MERGE_CONFLICT = {
			found = false,
			label = "CONFLICT",
			color = "#ff7f7b",
		},
		STASHED = {
			found = false,
			label = "STASHED",
			color = "#ffbf70",
		},
		STAGED = {
			found = false,
			label = "STAGED",
			color = "#90bee1",
		},
	},
}

-- 1. if there is a U in a row, or a row is AA, merge conflict
-- 2. if anything else in left column, simply indicate staged
-- 3. if not either above, treat as normal

local function format_status()
	local status, git_status, stash_exists = pcall(function()
		-- `-C` arg allows us to execute git in a different path as if it was the cwd.
		local handle = io.popen("git -C " .. cwd .. " status --porcelain")
		assert(handle ~= nil)
		local status = handle:read("*a")
		handle:close()
		handle = io.popen("git -C " .. cwd .. " stash list")
		assert(handle ~= nil)
		local stash = handle:read("*a")
		handle:close()
		return status, stash
	end)

	if not status or (git_status == "" and stash_exists == "") then
		return ""
	end

	local lines = {}

	for match in string.gmatch(git_status, "([^\n]+)") do
		table.insert(lines, string.sub(match, 1, 2))
	end

	for _, v in pairs(lines) do
		if string.find(v, "U") or v == "AA" then
			data.switches.MERGE_CONFLICT.found = true
		elseif string.len(stash_exists) > 0 then
			data.switches.STASHED.found = true
		elseif string.sub(v, 1, 1) ~= " " and string.sub(v, 1, 1) ~= "?" then
			data.switches.STAGED.found = true
		else
			for char, t in pairs(data.chars) do
				if string.find(v, char) then
					t.found = true
				end
			end
		end
	end

	local num_statuses = 0
	for _, t in pairs(data.chars) do
		if t.found then
			num_statuses = num_statuses + 1
		end
	end
	for _, t in pairs(data.switches) do
		if t.found then
			num_statuses = num_statuses + 1
		end
	end

	local STATUS_SIZE = 10

	local output = ""
	for _, t in pairs(data.chars) do
		if t.found then
			output = output
				.. "#[fg="
				.. t.color
				.. "]"
				.. string.sub(t.label, 1, math.floor(STATUS_SIZE / num_statuses))
				.. "#[default]"
		end
	end
	for _, t in pairs(data.switches) do
		if t.found then
			output = output
				.. "#[fg="
				.. t.color
				.. "]"
				.. string.sub(t.label, 1, math.floor(STATUS_SIZE / num_statuses))
				.. "#[default]"
		end
	end

	return output
end

io.stdout:write(format_status())
