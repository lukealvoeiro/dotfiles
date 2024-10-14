return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        keymaps = {
          node_incremental = "v",
          node_decremental = "V",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    commit = "2e5aef3",
    config = function()
      require("treesitter-context").setup({ multiline_threshold = 1, zindex = 30 })

      local utils = require("custom.utils")
      local line_nr = utils.get_hlgroup("LineNr")
      local line_numbers = utils.get_hlgroup("LineNrAbove", line_nr)
      local ts_context_bottom = utils.shallow_copy(line_numbers)
      local ts_context = utils.shallow_copy(line_numbers)

      ts_context_bottom.underline = true
      ts_context_bottom.fg = nil
      ts_context_bottom.sp = line_numbers.fg ~= "NONE" and line_numbers.fg or line_nr.fg

      vim.api.nvim_set_hl(0, "TreesitterContext", ts_context)
      vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", ts_context)
      vim.api.nvim_set_hl(0, "TreesitterContextBottom", ts_context_bottom)
    end,
  },
  {
    "abecodes/tabout.nvim",
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
    dependencies = { -- These are optional
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
      "hrsh7th/nvim-cmp",
    },
    opt = true, -- Set this to true if the plugin is optional
    event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },
}
