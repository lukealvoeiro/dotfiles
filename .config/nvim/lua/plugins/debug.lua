return {
  {
    "mfussenegger/nvim-dap",
    keys = function()
      local dap = require("dap")
      return {
        { "<F5>", dap.continue, desc = "Debug: Start/Continue" },
        { "<F11>", dap.step_into, desc = "Debug: Step Into" },
        { "<F10>", dap.step_over, desc = "Debug: Step Over" },
        { "<F9>", dap.step_out, desc = "Debug: Step Out" },
        { "<leader>db", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
        {
          "<leader>dB",
          function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
          end,
          desc = "Debug: Set Breakpoint",
        },
      }
    end,
    opts = function(_, opts)
      local dap = require("dap")
      -- run using tmux as the integrated terminal doesn't work well
      dap.defaults.fallback.force_external_terminal = true
      dap.defaults.fallback.external_terminal = {
        command = "wezterm",
        args = { "cli", "split-pane" },
      }
      return opts
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      controls = {
        element = "scopes",
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.33 },
            { id = "stacks", size = 0.33 },
            { id = "breakpoints", size = 0.33 },
          },
          size = 38,
          position = "left",
        },
      },
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    dap.listeners.before.attach.dapui = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui = function()
      dapui.close()
    end

    vim.api.nvim_create_autocmd("FileType", {
      -- mark the buffer as a dapui buffer and don't add other things to it
      group = vim.api.nvim_create_augroup("winfixbuf-dapui", { clear = true }),
      pattern = {
        "dapui_watches",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_scopes",
        "dapui_console",
        "dap-repl",
      },
      callback = function()
        vim.opt_local.winfixbuf = true
        vim.cmd.Neotree("close")
      end,
    })
  end,
}
