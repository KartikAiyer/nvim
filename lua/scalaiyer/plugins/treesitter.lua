return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
  branch = "master",
  config = function()
    local treesitter = require 'nvim-treesitter.configs'

    treesitter.setup({
      ensure_installed ={
        "c",
        "cpp",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "cmake",
        "markdown",
        "markdown_inline",
        "html",
        "javascript",
        "typescript",
        "dart",
        "gitignore",
        "dockerfile",
        "doxygen",
        "bash",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm"
        }
      }
    })
  end
}
