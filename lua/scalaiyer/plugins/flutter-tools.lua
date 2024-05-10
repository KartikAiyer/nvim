return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },
  config = function()
    local on_attach = LspConfigOnAttach -- Defined in globals.lua

    require("flutter-tools").setup {
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = true
        }
      },
      widget_guides = {
        enabled = true,
      },
      lsp = {
        color = {
          enabled = true,
          background = true,
        },
        on_attach = on_attach,
      },
      debugger = {           -- integrate with nvim dap + install dart code debugger
        enabled = true,
        run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
        -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
        -- see |:help dap.set_exception_breakpoints()| for more info
        exception_breakpoints = {
          "uncaught",
          "raised",
        },
        register_configurations = function(_)
          require("dap").configurations.dart = {
         --   {
         --     name = "Launch dart",
         --     request = "launch",
         --     type = "dart"
         --   }
          }
          require("dap.ext.vscode").load_launchjs()
        end,
      },
    }
  end,
}
