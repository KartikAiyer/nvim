local function configMason()
  local mason = require("mason")
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    },
  })
end
local function configMasonLspConfig()
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup({
    ensure_installed = {
      "clangd",
      "pyright",
      "lua_ls",
      "bashls",
      "kotlin_language_server",
      "gradle_ls",
      "jsonls",
      "yamlls",
      "ansiblels",
      "sqlls",
    },
    automatic_installation = true,
  })
end

local function configLspConfig()
  local lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local on_attach = LspConfigOnAttach
  -- Used to enable auto copletion
  local capabilities = cmp_nvim_lsp.default_capabilities()

  -- Change the Diagnostic symbols in the sign column (gutter)
  -- (not in youtube nvim video)
  local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end
  vim.lsp.set_log_level("trace")
  lspconfig["clangd"].setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      client.server_capabilities.signatureHelpProvider = false
      vim.keymap.set("n", "<leader>th", "<cmd>ClangdSwitchSourceHeader<cr>",
        { desc = "Switch between source and header" })
      vim.keymap.set("n", "<leader>tH",
        function()
          vim.cmd("vsplit")
          vim.cmd("ClangdSwitchSourceHeader")
        end,
        { desc = "Open header or source in separate vsplit" }
      )

      on_attach(client, bufnr)
    end,
    cmd = { "clangd", "--background-index", "--clang-tidy" }
  })

  lspconfig["pyright"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })

  lspconfig["bashls"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })

  lspconfig["dockerls"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })

  lspconfig["docker_compose_language_service"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })

  lspconfig["kotlin_language_server"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })

  lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            -- Depending on the usage, you might want to add additional paths here.
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })
    end,
    settings = {
      Lua = {}
    },
    filetypes={
      "lua",
      "lua.bustedspec"
    }
  })
  lspconfig["cmake"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })

  lspconfig["terraformls"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })
  lspconfig["gradle_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })
  lspconfig["jsonls"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })
  lspconfig["yamlls"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })
  lspconfig["sqlls"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })
end

-- Also configures null-ls
local function configMasonNullLs()
  local null_ls = require('null-ls')

  require("mason-null-ls").setup({
    ensure_installed = {
      -- Opt to list sources here, when available in mason.
      "cmake_lint",
      "cmake_format",
      "clang_format",
      "proselint",
      "refactoring",
      "ts_node_action",
      "luasnip",
      "spell",
      "tags",
      "actionlint",
      "buf",
      "checkmake",
      "clazy",
      "cppcheck",
      "hadolint",
      "ktlint",
      "markdownlint",
      "mypy",
      "selene",
      "terraform_validate",
      "todo_comments",
      "trail_space",
      "black",
      "isort",
      "stylua",
      "dictionary",
      "printenv",
      "pylint",
      "ansiblelint",
      "sql-formatter",
    },
    methods = {
      diagnostics = true,
      formatting = true,
      code_actions = true,
      completion = true,
      hover = true,
    },
    automatic_installation = false,
    handlers = {
      refactoring = function(source_name, methods)
        null_ls.register(null_ls.builtins.code_actions.refactoring.with({
          filetypes = { "go", "javascript", "lua", "python", "typescript", "cpp", "c", "java", "sql" }
        }))
      end
    },
  })
end

local function configDap()
  require("mason-nvim-dap").setup({
    ensure_installed = { 'python', 'kotlin' }
  })
  local dap = require "dap"
  local dapui = require "dapui"

  dap.adapters.lldb = {
    type = "executable",
    command = "lldb-dap",
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

  local dapPython = require('dap-python')
  dapPython.setup("python")
  dapPython.test_runner = 'pytest'

  dapui.setup()
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end

  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end

  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end

  dap.listeners.before.event_closed.dapui_config = function()
    dapui.close()
  end
  vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", {desc = "Continue Dap. Specify Exceutable if not started"})
  vim.keymap.set("n", "<leader>do", "<cmd>DapStepOver<CR>", {desc = "Dap Step Over"})
  vim.keymap.set("n", "<leader>di", "<cmd>DapStepInto<CR>", {desc = "Dap Step Into"})
  vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", {desc = "Dap Toggle Breakpoint"})
  vim.keymap.set("n", "<leader>dq", "<cmd>DapDisconnect<CR>", {desc = "Dap Disconnect"})
end
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "nvimtools/none-ls.nvim",
    {
      "rcarriga/nvim-dap-ui",
    },
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python",
    "nvim-neotest/nvim-nio",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {}
    }
  },
  config = function()
    configMason()
    configMasonLspConfig()
    configLspConfig()
    configMasonNullLs()
    configDap()
  end
}
