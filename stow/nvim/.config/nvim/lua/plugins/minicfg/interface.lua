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

-- File explorer like oil.nvim
require("mini.files").setup()
map("n", "<leader>e", "<CMD>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", { desc = "Config files picker" })

-- mini.extra adds many useful pickers.
require("mini.extra").setup()
-- note, below mapping might be messy when used in tandem with lazydev.
map("n", "<leader>ws", '<CMD>Pick lsp scope="workspace_symbol"<CR>', { desc = "Pick LSP workspace symbols" })
map("n", "<leader>ds", '<CMD>Pick lsp scope="document_symbol"<CR>', { desc = "Pick LSP document symbols" })
-- map("n", "<leader>fe", "<CMD>Pick explorer<CR>", { desc = "Open an explorer" })
map("n", "<leader>fe", function()
    local current_buf_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    vim.cmd("Pick explorer cwd='" .. current_buf_dir .. "'")
end, { desc = "Open an explorer" })
-- mini.icons for picker icons
require("mini.icons").setup()
