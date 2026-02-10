-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
require("custom.highlights")

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    -- vim.b.autoformat
    vim.b.autoformat = false
  else
    vim.g.autoformat = false
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.autoformat = true
  vim.g.autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
vim.api.nvim_create_user_command("FormatToggle", function()
  vim.b.autoformat = not vim.b.autoformat
  vim.g.autoformat = not vim.g.autoformat
end, {
  desc = "Toggle autoformat-on-save",
})

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    vim.schedule(function()
      local wins = vim.api.nvim_list_wins()
      if #wins == 1 then
        local buf = vim.api.nvim_win_get_buf(wins[1])
        if vim.fn.bufname(buf) == "" and not vim.bo[buf].modified and vim.bo[buf].buftype == "" then
          vim.cmd("quit")
        end
      end
    end)
  end,
})
