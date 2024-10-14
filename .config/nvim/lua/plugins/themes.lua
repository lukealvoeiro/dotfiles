return {
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },
  {
    "Shatur/neovim-ayu",
    config = function()
      local colors = require("ayu.colors")
      colors.generate(false)
      require("ayu").setup({
        terminal = true,
        mirage = true,
        overrides = function()
          local normal_bg = "#242835"
          local selection_color = "#38485d"
          local line_colors = "#54565d"
          local current_line_bg = "#313540"
          local neotree_sidebar_bg = "#353944"
          local neotree_line = "#54565d"
          return {
            LineNr = { fg = colors.special, bold = true },
            LineNrAbove = { fg = line_colors },
            LineNrBelow = { fg = line_colors },
            WinSeparator = { fg = line_colors },
            Visual = { bg = selection_color },
            CursorLine = { bg = current_line_bg },
            CursorLineNr = { fg = colors.special, bold = true },
            IncSearch = { fg = colors.keyword, bg = selection_color },
            Pmenu = { blend = vim.o.pumblend, bg = "#1c212b" },
            PmenuSel = { blend = 0, bg = selection_color },
            NeoTreeCursorLine = { bg = neotree_line },
            NeoTreeNormal = { bg = neotree_sidebar_bg },
            NeoTreeNormalNC = { bg = neotree_sidebar_bg },
            -- TODO: make anything that resembles staged be bold
            -- TODO: fix the lualine plugin
            Normal = { bg = normal_bg },
            NeoTreeGitAdded = { link = "GitSignsStagedAdd" },
            NeoTreeGitUnstaged = { link = "GitSignsChange" },
            NeoTreeGitModified = { link = "GitSignsChange" },
            NeoTreeGitUntracked = { link = "GitSignsAdd" },
            NeoTreeGitStaged = { link = "GitSignsStagedChange" },
          }
        end,
      })
    end,
  },
}
