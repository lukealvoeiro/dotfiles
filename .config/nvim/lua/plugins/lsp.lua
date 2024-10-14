return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- Modify the default options
      opts.window = {
        completion = require("cmp").config.window.bordered({ col_offset = -1 }),
        documentation = require("cmp").config.window.bordered({ col_offset = -1 }),
      }
      opts.preview = {
        border = "rounded",
      }
      opts.formatting = {
        format = function(_, item)
          local icons = LazyVim.config.icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          local content = item.abbr

          local fixed_width = false
          local win_width = vim.api.nvim_win_get_width(0)

          -- Set the max content width based on either: 'fixed_width'
          -- or a percentage of the window width, in this case 20%.
          -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
          local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

          -- Truncate the completion entry text if it's longer than the
          -- max content width. We subtract 3 from the max content width
          -- to account for the "..." that will be appended to it.
          if #content > max_content_width then
            item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 1) .. "…"
          else
            item.abbr = content .. (" "):rep(max_content_width - #content)
          end
          return item
        end,
      }
      return opts
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            pyright = {
              disableOrganizeImports = true, -- Using Ruff
              openFilesOnly = false,
              typeCheckingMode = "off",
            },
          },
        },
      },
    },
  },
}
