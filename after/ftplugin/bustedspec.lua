vim.keymap.set("n", "<leader>p", "<cmd>Telescope neovim-project discover<CR>", { desc = "Run NeoVim Project discover" })
vim.keymap.set(
  "n",
  "<leader><leader>t",
  "<cmd>PlenaryBustedFile %<CR>", 
  { desc = "Test the current spec file"}
)
