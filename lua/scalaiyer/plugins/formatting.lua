return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				cpp = { "clang_format" },
				lua = { "stylua" },
				json = { "prettier" },
				python = { "isort", "black" },
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>pp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range" })
	end,
}
