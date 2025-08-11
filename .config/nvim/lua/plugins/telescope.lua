return {
  "ibhagwan/fzf-lua",
  opts = {
    fzf_opts = {
      ["--no-scrollbar"] = true,
    },
    defaults = {
      formatter = "path.filename_first",
    },
    previewers = {
      bat = {
        args = "--color=always --style=numbers,changes",
      },
    },
    grep = {
      rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
    },
    files = {
      rg_opts = "--color=never --files --hidden --follow -g '!.git'",
    },
  },
  keys = function()
    local fzf = require("fzf-lua")
    
    local all_file_search = function()
      return fzf.files({ 
        cmd = "rg --files --hidden --no-ignore",
        prompt = "Find All Files> "
      })
    end

    local find_projects = function(directory)
      directory = directory or "~/Development"
      local cmd = "find " .. directory .. " -maxdepth 1 -type d -print"
      fzf.fzf_exec(cmd, {
        prompt = "Find Directories> ",
        actions = {
          ["default"] = function(selected)
            if selected and #selected > 0 then
              local selected_path = selected[1]
              vim.api.nvim_set_current_dir(selected_path)
              require("oil").open_float(selected_path)
            end
          end,
        },
      })
    end

    local search_open_buffers = function()
      return fzf.buffers({
        show_all_buffers = true,
        ignore_current_buffer = true,
        sort_lastused = true,
        actions = {
          ["ctrl-d"] = { fn = fzf.actions.buf_del, reload = true },
        },
      })
    end

    local git_status_search = function()
      return fzf.git_status({
        preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
      })
    end

    local wk = require("which-key")
    wk.add({
      { "<leader>sa", group = "all" },
    })
    
    return {
      { "<leader>sh", fzf.help_tags, desc = "[S]earch [H]elp" },
      { "<leader>sk", fzf.keymaps, desc = "[S]earch [K]eymaps" },

      { "<leader>sf", fzf.files, desc = "[S]earch [F]iles" },
      { "<leader>saf", all_file_search, desc = "[S]earch [A]ll [F]iles" },
      { "<leader>st", fzf.builtin, desc = "[S]earch [T]elescope" },
      { "<leader>sw", fzf.grep_cword, desc = "[S]earch current [W]ord" },
      { "<leader>sg", fzf.live_grep, desc = "[S]earch by [G]rep" },
      { "<leader>sd", fzf.diagnostics_document, desc = "[S]earch [D]iagnostics" },
      { "<leader>ss", fzf.lsp_document_symbols, desc = "[S]earch [S]ymbols" },
      { "<leader>sl", fzf.resume, desc = "[S]earch [L]ast" },
      { "<leader>s.", fzf.oldfiles, desc = '[S]earch Recent Files ("." for repeat)' },
      { "<leader>sp", find_projects, desc = "[S]earch [P]rojects" },
      { "<leader><leader>", search_open_buffers, desc = "[ ] Find existing buffers" },
      {
        "<leader>sw",
        fzf.grep_visual,
        mode = "v",
        desc = "[S]earch Selection",
      },
      { "<leader>sv", git_status_search, desc = "[S]earch [V]CS" },
      { "<leader>sC", fzf.git_commits, desc = "[S]earch and checkout [C]ommit" },

      {
        "<leader>/",
        function()
          fzf.blines({
            winopts = {
              height = 0.4,
              width = 0.6,
            },
          })
        end,
        desc = "[/] Fuzzily search in current buffer",
      },

      {
        "<leader>s/",
        function()
          fzf.grep({
            search = "",
            prompt = "Live Grep in Open Files> ",
            rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
            fzf_opts = { ["--query"] = "" },
            -- Only search in open buffers
            cmd = "rg --column --line-number --no-heading --color=always --smart-case " .. table.concat(vim.tbl_map(function(buf)
              return vim.api.nvim_buf_get_name(buf)
            end, vim.api.nvim_list_bufs()), " "),
          })
        end,
        desc = "[S]earch [/] in Open Files",
      },

      {
        "<leader>sn",
        function()
          fzf.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "[S]earch [N]eovim files",
      },
    }
  end,
}
