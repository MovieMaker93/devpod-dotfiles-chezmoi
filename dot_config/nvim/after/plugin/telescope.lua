local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>ec", function()
	builtin.find_files({
		cwd = vim.fn.stdpath("config"),
	})
end)
vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<leader>qx", builtin.quickfix, {})
vim.keymap.set("n", "<leader>gh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>vc", builtin.commands, {})
vim.keymap.set("n", "<leader>vh", builtin.highlights, {})
vim.keymap.set("n", "<leader>ccs", builtin.colorscheme, {})
vim.keymap.set("n", "<leader>sr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>vws", builtin.lsp_workspace_symbols, {})
vim.keymap.set("n", "<leader>vwd", builtin.lsp_document_symbols, {})

local actions = require("telescope.actions")
require("telescope").setup({
	extensions = {
		fzf = {},
		wrap_results = true,
	},
	defaults = {
		mappings = {
			i = {
				["<c-e>"] = actions.file_vsplit,
				["<c-h>"] = actions.file_split,
			},
		},
	},
	pickers = {
		buffers = {
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer + actions.move_to_top,
				},
			},
		},
	},
})
