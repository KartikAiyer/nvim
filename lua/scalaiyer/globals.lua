function TablePrint(tbl, indent)
  if not indent then indent = 0 end
  local toprint = string.rep(" ", indent) .. "{\r\n"
  indent = indent + 2
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint .. k .. "= "
    end
    if (type(v) == "number") then
      toprint = toprint .. v .. ",\r\n"
    elseif (type(v) == "string") then
      toprint = toprint .. "\"" .. v .. "\",\r\n"
    elseif (type(v) == "table") then
      toprint = toprint .. TablePrint(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
    end
  end
  toprint = toprint .. string.rep(" ", indent - 2) .. "}"
  return toprint
end

function LspConfigOnAttach(_, bufnr)
  local keymap = vim.keymap

  local opts = { noremap = true, silent = true }

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

  opts.desc = "Show LSP symbols in workspace"
  keymap.set("n", "gs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)

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

  opts.desc = "Format buffer"
  keymap.set("n", "<leader><leader>f", vim.lsp.buf.format, opts)
end
