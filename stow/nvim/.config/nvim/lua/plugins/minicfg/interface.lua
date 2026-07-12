local map = vim.keymap.set

local MiniClue = require("mini.clue")
MiniClue.setup({
  triggers = {
    { mode = "n", keys = "g" },
    { mode = "n", keys = "<leader>" },
  },
  clues = {
    MiniClue.gen_clues.g(),
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

-- Statusline
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

      -- Default config. Same with just nil.
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      -- Allow submode to replace current mode if active
      mode = mode and require("submode").mode() or mode
      local git = MiniStatusline.section_git({ trunc_width = 40 })
      local diff = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location = MiniStatusline.section_location({ trunc_width = 75 })
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
      local overseer, overseer_hl = section_overseer({ trunc_width = 140 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = overseer_hl, strings = { overseer } },
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
      })
    end,
    inactive = nil,
  },
  use_icons = true,
})
-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
  return "%p%%"
end

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
