local types = require("luasnip.util.types")
local ls = require("luasnip")

local custom_snips = NeovimPath .. "/lua/snippets"
require("luasnip.loaders.from_lua").load({ paths = { custom_snips } })
require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = false,

	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",

	-- Autosnippets:
	enable_autosnippets = true,

	-- Crazy highlights!!
	store_selection_keys = "<Tab>",
	-- #vid3
	-- ext_opts = nil,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { " « ", "NonTest" } },
			},
			passive = {
				virt_text = { { "← Choice", "Comment" } },
			},
		},
	},
})

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

vim.keymap.set("i", "<c-u>", require("luasnip.extras.select_choice"))
