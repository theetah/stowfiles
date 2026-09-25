#!/usr/bin/env lua

local cwd = arg[1]

-- 2. if there is a U in a row, or a row is AA, merge conflict
-- 3. if anything else in left column, simply indicate staged

-- data:
-- letter (such as M)
-- count
-- label (such as Modified)
--
-- have separate counter for staged (keep functionality similar to starship)

-- TODO: colors
local counts = {
	M = {
		count = 0,
		label = "MODIFIED",
	},
	["?"] = {
		count = 0,
		label = "UNTRACKED",
	},
	A = {
		count = 0,
		label = "ADDED",
	},
	D = {
		count = 0,
		label = "DELETED",
	},
	R = {
		count = 0,
		label = "RENAMED",
	},
	C = {
		count = 0,
		label = "COPIED",
	},
	T = {
		count = 0,
		label = "TYPECHANGE",
	},
	MERGE_CONFLICT = false,
	STASHED = false,
	STAGED = false,
}

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

	-- fatal: not a git repository
	if not status then
		return ""
	end

	local lines = {}

	for match in string.gmatch(git_status, "([^\n]+)") do
		table.insert(lines, string.sub(match, 1, 2))
	end

	for _, v in pairs(lines) do
		print("ENTRY: " .. v)
		if string.find(v, "U") or v == "AA" then
			counts.MERGE_CONFLICT = true
		elseif string.len(stash_exists) > 0 then
			counts.STASHED = true
		elseif string.sub(v, 1, 1) ~= " " then
			counts.STAGED = true
		end
	end

	-- TODO:
	return ""
end

io.stdout:write(format_status())
