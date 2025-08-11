-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable snacks animations
vim.g.snacks_animate = false

vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
vim.opt.guicursor = ""
vim.opt.breakindent = true
vim.opt.pumblend = 15
vim.opt.scrolloff = 10
vim.opt.pumblend = 15
vim.opt.pumheight = 10

vim.opt.clipboard = ""

-- NEOVIDE
vim.o.guifont = "ZedMono Nerd Font:h17"
vim.g.neovide_remember_window_size = true
vim.g.neovide_transparency = 0.90
vim.g.neovide_window_blurred = true
vim.opt.linespace = -1
vim.g.neovide_input_macos_option_key_is_meta = "both"
