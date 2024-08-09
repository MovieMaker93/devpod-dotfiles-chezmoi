return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "jonarrien/telescope-cmdline.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		dir = "/home/moviemaker/workspace/opensources/telescope/telescope.nvim",
		keys = {
			{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find file" },
			{ "<leader>cmd", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("cmdline")
			pcall(require("telescope").load_extension, "fzf")
		end,
	},
	{
		"MovieMaker93/telescope-ghissue.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("telescope_ghissue")
			require("telescope_ghissue").setup({})
		end,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
	},
	{
		"kristijanhusak/vim-dadbod-completion",
	},
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				local blankline = require("ibl")
				blankline.setup({
					scope = {
						show_start = false,
					},
					indent = {
						char = "┊",
						tab_char = "┊",
						smart_indent_cap = true,
					},
					whitespace = {
						remove_blankline_trail = true,
					},
				})
			end,
		},
	},
}
