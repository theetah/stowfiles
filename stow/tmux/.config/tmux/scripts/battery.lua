#!/usr/bin/env lua

-- format expects %s, %d
local format = arg[1]

-- Source - https://stackoverflow.com/a/40195356
-- Posted by Hisham H M
-- Retrieved 2026-10-03, License - CC BY-SA 3.0
local function dirent_exists(dirent)
	local ok, err, code = os.rename(dirent, dirent)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

local function cat(dirent)
	-- need to suppress errors otherwise tmux might catch it
	local handle = io.popen("cat " .. dirent .. " 2>/dev/null")
	assert(handle ~= nil)
	local percentage = ""
	percentage = handle:read("*a")
	handle:close()
	return percentage
end

local function battery_stats(dirent)
	local ok, _ = dirent_exists(dirent)
	if ok then
		local p_ok, percent = pcall(cat, dirent .. "/capacity")
		local s_ok, status = pcall(cat, dirent .. "/status")
		if p_ok and s_ok then
			return tonumber(percent), status:gsub("\n", "")
		end
	end
end

local function percent_to_icon(p, s)
	local step = math.floor(p / 10)
	if s == "Discharging" then
		return string.sub("󰂃󰁺󰁻󰁼󰁽󰁾󰁿󰂀󰂁󰂂󰁹", 1 + step * 4, 4 + step * 4)
	elseif s == "Charging" then
		return string.sub("󰢟󰢜󰂆󰂇󰂈󰢝󰂉󰢞󰂊󰂋󰂅", 1 + step * 4, 4 + step * 4)
	end
end

local function battery()
	-- we try BAT0 and BAT1. on some systems like a PC, /sys/class/power_supply/
	-- typically won't exist and therefore we don't need to worry too much about edge cases.
	local percent, status = battery_stats("/sys/class/power_supply/BAT0")
	if percent == nil or status == nil then
		percent, status = battery_stats("/sys/class/power_supply/BAT1")
	end

	if percent == nil or status == nil then
		return ""
	end

	local icon = percent_to_icon(percent, status)
	if status == "Charging" then
		icon = "#[fg=" .. os.getenv("GREEN") .. "]" .. icon .. "#[fg=default]"
	elseif percent < 10 then
		icon = "#[fg=" .. os.getenv("RED") .. "]" .. icon .. "#[fg=default]"
	elseif percent < 25 then
		icon = "#[fg=" .. os.getenv("ORANGE") .. "]" .. icon .. "#[fg=default]"
	end

	local output = ""

	if format ~= nil then
		output = string.format(format, icon, percent)
	else
		output = " " .. icon .. " " .. tostring(percent) .. "% "
	end

	return output
end

io.stdout:write(battery())
