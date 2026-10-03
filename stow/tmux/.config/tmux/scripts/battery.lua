#!/usr/bin/env lua

-- format expects %s, %d
local format = arg[1]

local function cat(dirent)
	-- need to suppress errors otherwise tmux might catch it
	local handle = io.popen("cat " .. dirent .. " 2>/dev/null")
	assert(handle ~= nil)
	local percentage = ""
	percentage = handle:read("*a")
	handle:close()
	return percentage
end

local function percent_to_icon(p)
	local i = "󰁹"
	if p < 10 then
		i = "󰂃"
	elseif p < 20 then
		i = "󰁺"
	elseif p < 30 then
		i = "󰁻"
	elseif p < 40 then
		i = "󰁼"
	elseif p < 50 then
		i = "󰁽"
	elseif p < 60 then
		i = "󰁾"
	elseif p < 70 then
		i = "󰁿"
	elseif p < 80 then
		i = "󰂀"
	elseif p < 90 then
		i = "󰂁"
	elseif p < 100 then
		i = "󰂂"
	else
		i = "󰁹"
	end
	return i
end

local function battery()
	local percentage = nil
	-- we try BAT0 and BAT1. on some systems like a PC, /sys/class/power_supply/
	-- typically won't exist and therefore we don't need to worry too much about edge cases.
	local ok, bat = pcall(cat, "/sys/class/power_supply/BAT0/capacity")
	if ok and tonumber(bat) ~= nil then
		percentage = tonumber(bat)
	elseif tonumber(bat) == nil then
		-- seems like first call failed. try BAT1.
		ok, bat = pcall(cat, "/sys/class/power_supply/BAT1/capacity")
		if ok and tonumber(bat) ~= nil then
			percentage = tonumber(bat)
		end
	end

	if not percentage then
		return ""
	end

	if format ~= nil then
		return string.format(format, percent_to_icon(percentage), percentage)
	end

	return " " .. percent_to_icon(percentage) .. " " .. tostring(percentage) .. "% "
end

io.stdout:write(battery())
