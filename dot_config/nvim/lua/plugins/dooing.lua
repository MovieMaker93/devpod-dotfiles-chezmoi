return {
	"atiladefreitas/dooing",
	config = function()
		require("dooing").setup({
			keymaps = {
				toggle_window = "<leader>dt",
			},
			-- your custom config here (optional)
		})
	end,
}
