#!/usr/bin/env lua

local s = arg[1]

-- in case $HOME doesn't exist...
local home = assert(os.getenv("HOME"))

local begin, _ = string.find(s, home, 1, true)

if begin == 1 then
	s, _ = string.gsub(s, home, "~", 1)
end

io.stdout:write(s)
