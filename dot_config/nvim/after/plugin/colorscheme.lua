require("tokyonight").setup({
	style = "storm",
	terminal_colors = true,
	transparent = true,
})
vim.cmd.colorscheme("gruvbox-material")
vim.opt.termguicolors = true
require("bufferline").setup({
	options = {
		numbers = "ordinal",
	},
})

local notify = require("notify")
notify.setup({
	render = "wrapped-compact",
	timeout = 2500,
})
