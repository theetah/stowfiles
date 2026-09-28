#!/usr/bin/env lua
-- I understand this is not the most portable language for this endeavor.

-- arbitrary input sanitization
local s = arg[1]
local format = arg[2]
if string.find(s, "python") then
	s = "python"
end

-- find use for  ?
local icons = {
	-- languages, etc.
	sh = "",
	csh = "%",
	zsh = "",
	tcsh = "%",
	bash = "",
	fish = ">", -- alternatives include "󰻳" "󰈺" "" "" ""
	lua = "",
	python = "",
	-- development/editors
	nvim = "",
	emacs = "",
	nano = "",
	micro = "",
	code = "",
	codium = "",
	git = "󰊢",
	tmux = "",
	["[tmux]"] = "", -- in practice, doesn't seem to appear often
	-- GNU(-like) utilities
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
	-- non-default tools
	fd = "",
	rg = "",
	fzf = "",
	bat = "󰈙",
	bcompare = "",
	flatpak = "󰏖",
}

local output = icons[s] or ""

if format ~= nil then
	output = string.format(format, output)
end

io.stdout:write(output)
