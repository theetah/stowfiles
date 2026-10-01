#!/usr/bin/env lua

local s = arg[1]
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
	cp = "",
	rm = "",
	man = "",
	less = "",
	more = "",
	cat = "󰈙",
	find = "",
	grep = "",
	ssh = "󰌘",
	history = "",
	ping = "󰀃",
	fd = "",
	rg = "",
	fzf = "",
	bat = "󰈙",
	bcompare = "",
	flatpak = "󰏖",
}

local output = icons[s] or DEFAULT_ICON

if format ~= nil then
	output = string.format(format, output)
end

io.stdout:write(output)
