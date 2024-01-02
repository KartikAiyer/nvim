return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    {
      "jose-elias-alvarez/null-ls.nvim",
      event = "VeryLazy",
      config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.clang_format,
          }
        })
      end
    },
  },
  config = function()
    local mason = require("mason")

    local mason_lspconfig = require("mason-lspconfig")
    mason.setup({
      ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
      },
    })
    mason_lspconfig.setup({
      ensure_installed = {
        "clangd",
        "pyright",
        "lua_ls",
        "bashls",
        "kotlin_language_server",
      },
      automatic_installation = true,
    })
  end
}
