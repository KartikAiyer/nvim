return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
    theme = "gruvbox",
    --[[
    sections = {
      lualinx_x = {
        {require('mcphub.extensions.lualine')},
      }
    }
    ]]--
  },
}
