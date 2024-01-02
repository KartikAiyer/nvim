return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local opts = {
			size = 20, --| function(term)
			--if term.direction == "horizontal" then
			--  return 15
			--elseif term.direction == "vertical" then
			--  return vim.o.columns * 0.4
			--end
			--end,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			autochdir = false,
			shade_terminals = true,
			shading_factor = "50",
			direction = "float",
			close_on_exit = true,
			auto_scroll = true,
			persist_size = true,
			terminal_mappings = true,
			start_in_insert = true,
			insert_mappings = true,
			shell = vim.o.shell,
		}
		local tterm = require("toggleterm")
		tterm.setup(opts)

		function _G.set_terminal_keymaps()
			local op = { noremap = true }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], op)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], op)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], op)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], op)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], op)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], op)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], op)
		end
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
