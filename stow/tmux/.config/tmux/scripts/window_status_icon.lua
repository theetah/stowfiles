#!/usr/bin/env lua
-- I understand this is not the most portable language for this endeavor.
-- Too bad! Shell languages are not fun to work with.

-- print(arg[1])

-- some arbitrary input sanitization
local s = arg[1]
if string.find(s, "python") then
	s = "python"
end

-- find use for  ?
local icons = {
	-- languages, etc.
	sh = "",
	csh = "%",
	zsh = "%",
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
	rm = "󱀷",
	man = "󰈙",
	less = "󰈙",
	more = "󰈙",
	find = "",
	grep = "",
	ssh = "󰌘",
	history = "",
	-- non-default tools
	fd = "",
	rg = "",
	fzf = "",
	bcompare = "",
	flatpak = "󰏖",
}

io.stdout:write(icons[s] or "")
