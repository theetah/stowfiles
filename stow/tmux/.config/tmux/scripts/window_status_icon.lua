#!/usr/bin/env lua

local s = arg[1]
-- format expects %s
local format = arg[2]

-- arbitrary input sanitization
if string.find(s, "python") then
	s = "python"
end

local DEFAULT_ICON = ""

local icons = {
	---------------
	-- LANGUAGES --
	---------------
	sh = "",
	csh = "%",
	zsh = "",
	tcsh = "%",
	bash = "",
	fish = ">", -- alternatives include "󰻳" "󰈺" "" "" ""
	lua = "",
	python = "",
	-----------------
	-- DEVELOPMENT --
	-----------------
	nvim = "",
	emacs = "",
	nano = "",
	micro = "",
	code = "",
	codium = "",
	git = "󰊢",
	tmux = "",
	["[tmux]"] = "", -- in practice, doesn't seem to appear often
	---------------
	-- UTILITIES --
	---------------
	sudo = "",
	doas = "",
	cp = "",
	mv = "",
	rm = "",
	man = "󰭤",
	less = "󰭤",
	more = "󰭤",
	cat = "󰈙",
	bat = "󰈙",
	find = "",
	grep = "",
	fd = "",
	rg = "",
	fzf = "",
	ssh = "󰌘",
	history = "",
	ping = "󰀃",
	bcompare = "",
	flatpak = "",
	apt = "", -- unfortunately, these will not appear often, as they are often preceeded by `sudo`.
	rpm = "",
	dnf = "",
	pacman = "󰣇",
	apk = "",
	["xbps-install"] = "",
}

local output = icons[s] or DEFAULT_ICON

if format ~= nil then
	output = string.format(format, output)
end

io.stdout:write(output)
