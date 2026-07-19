-- Statusline
local function section_scrollbar(args)
  vim.api.nvim_set_hl(0, "MiniStatuslineScrollbar", {
    fg = "#b4b7b4",
    bg = "#393939",
    reverse = true,
  })
  if MiniStatusline.is_truncated(args.trunc_width) then
    return "▓", "MiniStatuslineScrollbar"
  end
  local line_current = vim.fn.line(".")
  local line_end = vim.fn.line("$")
  local char = ""
  local p = line_current / line_end
  -- █▇▆▅▄▃▂▁
  if line_end == 1 then
    char = "▓"
  else
    if p < 0.125 then
      char = "█"
    elseif p < 0.250 then
      char = "▇"
    elseif p < 0.375 then
      char = "▆"
    elseif p < 0.500 then
      char = "▅"
    elseif p < 0.625 then
      char = "▄"
    elseif p < 0.750 then
      char = "▃"
    elseif p < 0.875 then
      char = "▂"
    elseif p < 1.00 then
      char = "▁"
    else
      char = " "
    end
  end
  return char, "MiniStatuslineScrollbar"
end

local statusline = require("mini.statusline")
statusline.setup({
  content = {
    active = function()
      local function section_overseer(args)
        if MiniStatusline.is_truncated(args.trunc_width) then
          return "", nil
        end
        local overseer = require("overseer")
        local tasks = overseer.list_tasks({
          status = {
            overseer.STATUS.PENDING,
            overseer.STATUS.RUNNING,
            overseer.STATUS.SUCCESS,
            overseer.STATUS.FAILURE,
            overseer.STATUS.CANCELED,
          },
          sort = require("overseer.task_list").sort_finished_recently,
        })

        local recent_task = tasks[1]
        if recent_task then
          if MiniStatusline.is_truncated(args.trunc_width) then
            return recent_task.status, "Overseer" .. recent_task.status
          else
            return string.format("%s: %s", recent_task.name, recent_task.status), "Overseer" .. recent_task.status
          end
        else
          return nil, nil
        end
      end

      -- very similar to builtin function, but I made a few changes to be more straightforward.
      local function section_lsp(args)
        if MiniStatusline.is_truncated(args.trunc_width) then
          return ""
        end
        local attached_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
        -- lazy dumb method, but I don't expect more than one client per buffer usually
        local client = attached_clients[1]
        if client == nil then
          return ""
        end

        if client.initialized and not client:is_stopped() then
          -- TODO: find better icon?
          return " " .. client.name
        end
        return ""
      end

      -- rare usage of `math.huge`???
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = math.huge })
      -- set some hl groups here. indecisive if i should move them to colorscheme, but this seems more straightforward
      vim.api.nvim_set_hl(0, "MiniStatuslineModeSeparator" .. mode, {
        fg = vim.api.nvim_get_hl(0, { name = "MiniStatuslineMode" .. mode }).bg,
        bg = vim.api.nvim_get_hl(0, { name = "MiniStatuslineFileinfo" }).bg,
      })
      vim.api.nvim_set_hl(0, "MiniStatuslineSearchCount", {
        fg = vim.api.nvim_get_hl(0, { name = "CurSearch" }).bg,
        bg = vim.api.nvim_get_hl(0, { name = "MiniStatuslineFileinfo" }).bg,
      })
      -- Allow submode to replace current mode if active
      local submode = require("submode").mode()
      if submode ~= nil then
        mode = mode and string.sub(submode, 1, 1) or mode
      end
      local git = MiniStatusline.section_git({ trunc_width = 40 })
      local diff = MiniStatusline.section_diff({ trunc_width = 75, icon = "󰇂" })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp = section_lsp({ trunc_width = 75 })
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      -- local location = MiniStatusline.section_location({ trunc_width = 75 })
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
      local overseer, overseer_hl = section_overseer({ trunc_width = 140 })
      local scrollbar, scrollbar_hl = section_scrollbar({ trunc_width = 25 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diff, lsp, diagnostics } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = overseer_hl, strings = { overseer } },
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        -- nil -> keep previous section highlight
        { hl = "MiniStatuslineSearchCount", strings = { search } },
        "%#" .. scrollbar_hl .. "#" .. scrollbar,
        "%#MiniStatuslineFileinfo# ",
        -- "%#MiniStatuslineMode" .. mode .. "# ",
        -- "%#MiniStatuslineModeSeparator" .. mode .. "#🮇",
      })
    end,
    inactive = function()
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      local scrollbar, scrollbar_hl = section_scrollbar({ trunc_width = 25 })
      -- override bg color here to be a bit darker
      vim.api.nvim_set_hl(0, "MiniStatuslineScrollbar", {
        fg = "#b4b7b4",
        bg = "#262626",
        reverse = true,
      })
      return MiniStatusline.combine_groups({
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        "%<", -- Mark general truncate point
        "%#" .. scrollbar_hl .. "#" .. scrollbar,
        "%#MiniStatuslineFilename# ",
      })
    end,
  },
  use_icons = true,
})

local map = vim.keymap.set

local MiniClue = require("mini.clue")
MiniClue.setup({
  triggers = {
    { mode = "n", keys = "g" },
    { mode = { "n", "x" }, keys = "<leader>" },
    { mode = { "n", "x" }, keys = "'" },
    { mode = { "n", "x" }, keys = "`" },
    { mode = { "n", "x" }, keys = '"' },
    { mode = { "i", "c" }, keys = "<C-r>" },
    { mode = "n", keys = "<C-w>" },
  },
  clues = {
    MiniClue.gen_clues.g(),
    MiniClue.gen_clues.marks(),
    MiniClue.gen_clues.windows(),
    MiniClue.gen_clues.registers(),
  },
  window = {
    delay = 500,
    config = {
      width = "auto",
    },
  },
})

-- Command Line
require("mini.cmdline").setup()

-- Tabline
require("mini.tabline").setup()
-- Tabline keymaps
map("n", "<S-l>", "<CMD>bnext<CR>", { desc = "next buffer" })
map("n", "<S-h>", "<CMD>bprevious<CR>", { desc = "previous buffer" })
map("n", "<leader>bd", "<CMD>bdelete<CR>", { desc = "delete current buffer" })

-- Pickers
local MiniPick = require("mini.pick")
MiniPick.setup()

-- Allow files picker to change its cwd
MiniPick.registry.files = function(local_opts)
  local opts = { source = { cwd = local_opts.cwd } }
  local_opts.cwd = nil
  return MiniPick.builtin.files(local_opts, opts)
end

local config_directory = vim.fn.stdpath("config")

map("n", "<leader>ff", "<CMD>Pick files<CR>", { desc = "File picker" })
map("n", "<leader>fo", "<CMD>Pick oldfiles<CR>", { desc = "Oldfiles picker" })
map("n", "<leader>fc", '<CMD>Pick files cwd="' .. config_directory .. '"<CR>', { desc = "Config files picker" })
-- mini.extra adds many useful pickers.
require("mini.extra").setup()
-- note, below mapping might be messy when used in tandem with lazydev.
map("n", "<leader>ws", '<CMD>Pick lsp scope="workspace_symbol"<CR>', { desc = "Pick LSP workspace symbols" })
map("n", "<leader>ds", '<CMD>Pick lsp scope="document_symbol"<CR>', { desc = "Pick LSP document symbols" })
map("n", "<leader>e", "<CMD>Pick explorer<CR>", { desc = "Open an explorer" })
-- mini.icons for picker icons
require("mini.icons").setup()
