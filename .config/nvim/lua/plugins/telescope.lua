return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
  },
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--hidden",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
    },
  },
  keys = function()
    local builtin = require("telescope.builtin")
    local all_file_search = function()
      return builtin.find_files({ hidden = true, no_ignore = true, prompt_title = "Find All Files" })
    end

    local find_projects = function(directory)
      directory = "~/Development" or directory
      require("telescope.builtin").find_files({
        prompt_title = "Find Directories",
        cwd = directory,
        find_command = { "sh", "-c", "find " .. directory .. " -maxdepth 1 -type d -print" },
        entry_maker = function(entry)
          return {
            value = entry,
            display = function()
              -- TODO: use a MiniIconsDirectory highlight group for the directory icon
              -- TODO: only display the last part of the path
              local icon = require("mini.icons").get("default", "Directory")
              return icon .. " " .. entry
            end,
            ordinal = entry,
            path = entry,
          }
        end,
        attach_mappings = function(_, map)
          map("i", "<CR>", function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            require("telescope.actions").close(prompt_bufnr)
            local selected_path = selection.path or selection[1]
            vim.api.nvim_set_current_dir(selected_path)
            require("oil").open_float(selected_path)
          end)
          return true
        end,
      })
    end

    local search_open_buffers = function()
      return builtin.buffers({
        show_all_buffers = true,
        ignore_current_buffer = true,
        sort_lastused = true,
        initial_mode = "normal",
        sort_mru = true,
        attach_mappings = function(prompt_bufnr, map)
          map("n", "d", function()
            require("telescope.actions").delete_buffer(prompt_bufnr)
          end)
          return true
        end,
      })
    end

    local git_status_search = function()
      return builtin.git_status({
        initial_mode = "normal",
        col_width = 1,
        git_icons = {
          added = "A",
          changed = "M",
          deleted = "D",
          copied = "M",
          renamed = "R",
          unmerged = "U",
          untracked = "A",
        },
      })
    end

    local wk = require("which-key")
    wk.add({
      { "<leader>sa", group = "all" },
    })
    local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
    return {
      { "<leader>sh", builtin.help_tags, desc = "[S]earch [H]elp" },
      { "<leader>sk", builtin.keymaps, desc = "[S]earch [K]eymaps" },

      { "<leader>sf", builtin.find_files, desc = "[S]earch [F]iles" },
      { "<leader>saf", all_file_search, desc = "[S]earch [A]ll [F]iles" },
      { "<leader>st", builtin.builtin, desc = "[S]earch [T]elescope" },
      { "<leader>sw", live_grep_args_shortcuts.grep_word_under_cursor, desc = "[S]earch current [W]ord" },
      {
        "<leader>sg",
        require("telescope").extensions.live_grep_args.live_grep_args,
        desc = "[S]earch by [G]rep",
      },
      { "<leader>sd", builtin.diagnostics, desc = "[S]earch [D]iagnostics" },
      { "<leader>ss", builtin.lsp_document_symbols, desc = "[S]earch [S]ymbols" },
      { "<leader>sl", builtin.resume, desc = "[S]earch [L]ast" },
      { "<leader>s.", builtin.oldfiles, desc = '[S]earch Recent Files ("." for repeat)' },
      { "<leader>sp", find_projects, desc = "[S]earch [P]rojects" },
      { "<leader><leader>", search_open_buffers, desc = "[ ] Find existing buffers" },
      {
        "<leader>sw",
        live_grep_args_shortcuts.grep_visual_selection,
        mode = "v",
        desc = "[S]earch Selection",
      },
      { "<leader>sv", git_status_search, desc = "[S]earch [V]CS" },
      { "<leader>sC", builtin.git_commits, desc = "[S]earch and checkout [C]ommit" },

      -- Slightly advanced example of overriding default behavior and theme
      {
        "<leader>/",
        function()
          -- You can pass additional configuration to Telescope to change the theme, layout, etc.
          builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            -- winblend = 10,
            previewer = true,
          }))
        end,
        desc = "[/] Fuzzily search in current buffer",
      },

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      {
        "<leader>s/",
        function()
          builtin.live_grep({
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
          })
        end,
        desc = "[S]earch [/] in Open Files",
      },

      -- Shortcut for searching your Neovim configuration files
      {
        "<leader>sn",
        function()
          builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "[S]earch [N]eovim files",
      },
    }
  end,
}
