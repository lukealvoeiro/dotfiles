return {
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "folke/noice.nvim",
    opts = function()
      return {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = { enabled = false },
          signature = { enabled = false },
        },
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        cmdline = {
          enabled = true,
          menu = "popup",
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
        },
        views = {
          -- Clean cmdline_popup + palette
          cmdline_popup = {
            position = {
              row = 8,
              col = "50%",
            },
            border = {
              style = "rounded",
            },
          },
          cmdline_popupmenu = {
            relative = "editor",
            position = {
              row = 11,
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
              max_height = 15,
            },
            border = {
              style = "rounded",
            },
            win_options = {
              winhighlight = { NormalFloat = "NormalFloat", FloatBorder = "NoiceCmdlinePopupBorder" },
            },
          },
          hover = {
            border = {
              style = "rounded",
            },
          },
          confirm = {
            border = {
              style = "rounded",
            },
          },
          popup = {
            border = {
              style = "rounded",
            },
          },
        },
      }
    end,
  },
}
