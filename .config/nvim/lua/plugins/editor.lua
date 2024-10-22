local close_in_float = {
  function()
    if require("custom.utils").is_curr_buffer_float() then
      require("oil.actions").close.callback()
    end
  end,
  desc = "Close in float",
  mode = "n",
}

return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "+",
        function()
          local gitsigns = require("gitsigns")

          local hunks = gitsigns.get_hunks()
          local buf_name = vim.api.nvim_buf_get_name(0)

          if not buf_name:match("^gitsigns://") and not (hunks and next(hunks) ~= nil) then
            vim.notify("No git diff for this file", vim.log.levels.WARN)
            return
          end
          -- check if buffer starts with gitsigns prefix
          local buffers = vim.api.nvim_list_bufs()
          -- Iterate over all buffers
          for _, buf in ipairs(buffers) do
            -- Get the name of the buffer
            local buf_name = vim.api.nvim_buf_get_name(buf)

            -- Check if the buffer name starts with 'gitsigns://'
            if buf_name:match("^gitsigns://") then
              -- Close the buffer
              vim.api.nvim_buf_delete(buf, { force = true })
              return
            end
          end

          gitsigns.diffthis("@")
        end,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "3rd/image.nvim",
      dependencies = {
        {
          "vhyrro/luarocks.nvim",
          priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
          config = true,
          opts = {
            rocks = { "magick" },
          },
        },
      },
      opts = {
        backend = "kitty",
      },
    },
    keys = function()
      return {
        {
          "\\",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
          end,
          desc = "Toggle NeoTree",
        },
      }
    end,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            ".DS_Store",
            -- 'thumbs.db',
          },
          never_show = {},
        },
      },
      close_if_last_window = true,
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "", -- this can only be used in the git_status source
            renamed = "", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        mappings = {
          ["<c-d>"] = { "scroll_preview", config = { direction = -15 } },
          ["<c-u>"] = { "scroll_preview", config = { direction = 15 } },
        },
      },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = {},
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      lsp_file_methods = {
        autosave_changes = "unmodified",
      },
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = false,
        ["<C-l>"] = false,
        ["q"] = close_in_float,
        ["<Esc>"] = close_in_float,
        ["yp"] = {
          desc = "Copy filepath to system clipboard",
          callback = function()
            require("oil.actions").copy_entry_path.callback()
            vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
          end,
        },
        ["yrp"] = {
          desc = "Copy relative filepath to system clipboard",
          callback = function()
            local entry = require("oil").get_cursor_entry()
            local dir = require("oil").get_current_dir()
            if not entry or not dir then
              return
            end
            local relpath = vim.fn.fnamemodify(dir, ":.")
            vim.fn.setreg("+", relpath .. entry.name)
          end,
        },
      },
      float = {
        -- Padding around the floating window
        padding = 5,
        max_width = 78,
        max_height = 40,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
    },
    keys = {
      { "-", "<cmd>lua require('oil').open_float()<CR>", desc = "Open oil" },
      { "_", "<cmd>Oil<CR>", desc = "Open oil" },
    },
  },

  { "tiagovla/scope.nvim" },
}
