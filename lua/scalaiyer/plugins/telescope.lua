return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local builtin = require("telescope.builtin")
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<A-k>"] = actions.move_selection_previous, -- move to the previous selection
						["<A-j>"] = actions.move_selection_next,
						["<A-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
					n = {
						["<A-k>"] = actions.move_selection_previous, -- move to the previous selection
						["<A-j>"] = actions.move_selection_next,
						["<A-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})
		telescope.load_extension("fzf")
		local keymap = vim.keymap
		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Fuzzy find files in buffers" })
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Fuzzy find in help tags" })
		keymap.set("n", "<leader>fv", builtin.git_files, { desc = "Fuzzy find in git files" })
		keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recently opened files" })
		keymap.set("n", "<leader>*", "<cwd>Telescope grep_string<CR>", { desc = "Grep string under cursor in cwd" })
	end,
}
