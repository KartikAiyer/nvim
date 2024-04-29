return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    {"antosha417/nvim-lsp-file-operations", config = true}
  },
  config = function() 
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    local opts = {noremap = true, silent = true}
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      opts.desc = "Show LSP References"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Go to definition"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      opts.desc = "See available code actions"
      keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
  
      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "<leader>hd", vim.diagnostic.goto_prev, opts)

      opts.desc = "Go to next diagnostics"
      keymap.set("n", "<leader>ld", vim.diagnostic.goto_next, opts)

      opts.desc = "Show documentation for what is under the cursor"
      keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)

      opts.desc = "Restart Language Server"
      keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)

      opts.desc = "Format buffer"
      keymap.set("n", "<leader><leader>f", vim.lsp.buf.format, opts)
    end
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
        vim.keymap.set("n", "<leader>th", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch between source and header" })
        vim.keymap.set("n", "<leader>tH",
                  function()
                    vim.cmd("vsplit")
                    vim.cmd("ClangdSwitchSourceHeader")
                  end,
                  { desc = "Open header or source in separate vsplit" }
        )

        on_attach(client, bufnr)
      end,
      cmd = {"clangd", "--background-index", "--clang-tidy"}
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
      settings = {
        Lua = {
          -- make the language server recognize vim global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            libarary = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    lspconfig["terraformls"].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })
  end
}
