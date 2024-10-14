vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Override all colorscheme highlights in a custom way",
  callback = function()
    vim.api.nvim_set_hl(0, "TelescopeResultsStaged", { link = "Added" })
    vim.api.nvim_set_hl(0, "TelescopeResultsUnstaged", { link = "Removed" })
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true, italic = true })

    -- Get the background color of the 'Normal' highlight group
    local normal_bg = require("custom.utils").get_hlgroup("Normal").bg

    -- Function to update highlight groups
    local function update_bg_color(group)
      local current_fg = require("custom.utils").get_hlgroup(group).fg
      vim.api.nvim_set_hl(0, group, { fg = current_fg, bg = normal_bg })
    end

    print("Updating highlight groups")

    -- Update the background for the DAP UI highlight groups
    local dap_ui_groups = {
      "DapUIRestartNC",
      "DapUIStepOutNC",
      "DapUIStepBackNC",
      "DapUIStepIntoNC",
      "DapUIStepOverNC",
      "DapUIPlayPauseNC",
      "DapUIUnavailableNC",
    }

    for _, group in ipairs(dap_ui_groups) do
      update_bg_color(group)
    end
  end,
})
