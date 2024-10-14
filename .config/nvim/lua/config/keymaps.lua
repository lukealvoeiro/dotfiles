-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Ctrl+z to suspend nvim. Remap Ctrl+z in the terminal to fg
vim.keymap.set("n", "<C-z", ":suspend", { desc = "Suspend nvim" })

-- SETTINGS FOR NEOVIDE
if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>", { desc = "Save file" }) -- Save
  vim.keymap.set("v", "<D-c>", '"+y', { desc = "Copy to clipboard" }) -- Copy
  vim.keymap.set("n", "<D-v>", '"+P', { desc = "Paste" }) -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P', { desc = "Paste" }) -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+", { desc = "Paste" }) -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli', { desc = "Paste" }) -- Paste insert mode
end
-- END OF NEOVIDE CONFIG

vim.keymap.set("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<Left>", "<cmd>vertical resize +2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase Window Width" })

vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")

-- Note: lazyvim already sets undopoints for . , and ;
local undopoints = { "<BS>", "<left>", "<right>", "<up>", "<down>", "<CR>", "<C-w>", "<C-u>", " " }
for _, key in pairs(undopoints) do
  vim.keymap.set("i", key, "<C-g>u" .. key)
end

vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("Q", "q", {})

-- Marks
function DeleteMarksOnLine()
  local line = vim.fn.line(".")
  -- Loop through all marks (a-z, A-Z)
  for i = 97, 122 do -- a-z
    local mark_pos = vim.fn.getpos("'" .. string.char(i))
    if mark_pos[2] == line then
      vim.cmd("delm " .. string.char(i))
    end
  end
  for i = 65, 90 do -- A-Z
    local mark_pos = vim.fn.getpos("'" .. string.char(i))
    if mark_pos[2] == line then
      vim.cmd("delm " .. string.char(i))
    end
  end
end
vim.keymap.set("n", "`d", DeleteMarksOnLine, { noremap = true, silent = true })

-- Join line while keeping the cursor in the same position
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line" })

-- Keep cursor centred while scrolling up and down
vim.keymap.set("n", "<C-d>", "12<C-d>zz", { desc = "Scroll up" })
vim.keymap.set("n", "<C-u>", "12<C-u>zz", { desc = "Scroll down" })

-- Delete previous word in insert mode
vim.keymap.set("i", "<A-BS>", "<Esc>cvb", { desc = "Delete previous word in insert mode" })

-- Paste and Delete without yanking
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set("n", "x", '"_x', { desc = "Remove char without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

-- Insert new line between parens
vim.keymap.set("i", "<M-CR>", "<CR><Esc>O")
