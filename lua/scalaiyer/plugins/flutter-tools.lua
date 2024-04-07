return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },
  config = function()
    local keymap = vim.keymap
    local opts = {noremap = true, silent = true}
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      opts.desc = "Show LSP References"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Go to definition"
      keymap.set("n", "gd", vim.lsp.buf.definition, opts)

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

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
    end

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
      }
    }
  end,
}
