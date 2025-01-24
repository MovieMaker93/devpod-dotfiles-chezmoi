return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			-- Custom keymaps
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end)
			vim.keymap.set("n", "<leader>ds", function()
				vim.lsp.buf.document_symbol()
			end)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end)
			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end)
			vim.keymap.set("n", "<leader>dn", function()
				vim.diagnostic.goto_next()
			end)
			vim.keymap.set("n", "<leader>dp", function()
				vim.diagnostic.goto_prev()
			end)
			vim.keymap.set({ "v", "n" }, "<leader>vca", function()
				vim.lsp.buf.code_action()
			end)
			vim.keymap.set("n", "<leader>vrr", function()
				vim.lsp.buf.references()
			end)
			vim.keymap.set("n", "<leader>vrn", function()
				vim.lsp.buf.rename()
			end)
			vim.keymap.set("i", "<C-s>", function()
				vim.lsp.buf.signature_help()
			end)

			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"pylsp",
					"rust_analyzer",
					"yamlls",
					"terraformls",
					"lua_ls",
				},
			})
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("lspconfig").gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})
			require("lspconfig").lua_ls.setup({
				capabilites = capabilities,
				settings = {
					Lua = {
						workspace = {
							maxPreload = 4000, -- Increase maximum preload
							preloadFileSize = 4000, -- Increase the size limit in KB
						},
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local c = vim.lsp.get_client_by_id(args.data.client_id)
					if not c then
						return
					end

					if vim.bo.filetype == "lua" or vim.bo.filetype == "go" then
						-- Format the current buffer on save
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
							end,
						})
					end
				end,
			})
		end,
	},
}
