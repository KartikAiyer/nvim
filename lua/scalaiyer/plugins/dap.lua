return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      config = function(_, opts)
        local dap = require "dap"

        dap.adapters.lldb= {
          type = "executable",
          command = "lldb-vscode",
          name = "lldb",
        }

        local lldb = {
          name = "Launch lldb",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",
            "file"
            )
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
          runInTerminal = false
        }
        dap.configurations.cpp = {
          lldb
        }
      end
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {}
    }
  },
  opts = {},
  config =  function(_, opts)
    local dapui = require "dapui"
    local dap = require "dap"

    dapui.setup(opts)

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", {desc = "Continue Dap. Specify executable if not started"})
    vim.keymap.set("n", "<leader>do", "<cmd>DapStepOver<CR>", {desc = "Dap Step Over"})
    vim.keymap.set("n", "<leader>di", "<cmd>DapStepInto<CR>", {desc = "Dap Step Into"})
  end
}
