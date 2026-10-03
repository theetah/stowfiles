#!/usr/bin/env lua

local abspath = arg[1]

-- in case $HOME doesn't exist...
local home = assert(os.getenv("HOME"))

local begin, _ = string.find(abspath, home, 1, true)

if begin == 1 then
	abspath, _ = string.gsub(abspath, home, "~", 1)
end

io.stdout:write(abspath)
