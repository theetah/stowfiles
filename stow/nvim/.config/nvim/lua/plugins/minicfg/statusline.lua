local statusline = require("mini.statusline")
-- This module has a dedicated file due to how large it gets.
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
    local client = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })[1]
    -- lazy dumb method, but I don't expect more than one client per buffer usually
    if client == nil then
        return ""
    end

    if client.initialized and not client:is_stopped() then
        -- TODO: find better icon?
        return " " .. client.name
    end
    return ""
end

statusline.setup({
    content = {
        active = function()
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
            local git = MiniStatusline.section_git({ trunc_width = 40, icon = "󰊢" })
            local diff = MiniStatusline.section_diff({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75, icon = "" })
            local lsp = section_lsp({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            -- local location = MiniStatusline.section_location({ trunc_width = 75 })
            local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
            local overseer, overseer_hl = section_overseer({ trunc_width = 140 })

            return MiniStatusline.combine_groups({
                { hl = mode_hl, strings = { mode } },
                { hl = "MiniStatuslineDevinfo", strings = { git, diff, lsp, diagnostics } },
                "%<", -- Mark general truncate point
                { hl = "MiniStatuslineFilename", strings = { filename } },
                "%=", -- End left alignment
                { hl = "MiniStatuslineFilename", strings = { "%S" } },
                { hl = overseer_hl, strings = { overseer } },
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                -- nil -> keep previous section highlight
                { hl = "MiniStatuslineSearchCount", strings = { search ~= "" and vim.fn.getreg("/"), search } },
                { hl = "MiniStatuslineFileInfo", strings = { "%p%%" } },
            })
        end,
        inactive = function()
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })
            -- override bg color here to be a bit darker
            vim.api.nvim_set_hl(0, "MiniStatuslineScrollbar", {
                fg = "#777777",
                bg = "#262626",
                reverse = true,
            })
            return MiniStatusline.combine_groups({
                { hl = "MiniStatuslineFilename", strings = { filename } },
                "%=", -- End left alignment
                "%<", -- Mark general truncate point
            })
        end,
    },
    use_icons = true,
})
