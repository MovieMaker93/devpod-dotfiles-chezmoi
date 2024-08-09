return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		lazy = false,
		config = true,
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()
			local cmp_select = { behaviour = cmp.SelectBehavior.Select }

			cmp.setup({
				preselect = "item",
				completion = {
					completeopt = "menu,menuone,noselect",
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "crates" },
					{ name = "vim-dadbod-completion" },
				},
				-- formatting = lsp_zero.cmp_format(),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = require("lspkind").cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						menu = {
							buffer = "[buf]",
							nvim_lsp = "[LSP]",
							nvim_lua = "[api]",
							path = "[path]",
							luasnip = "[snip]",
							gh_issues = "[issues]",
							["vim-dadbod-completion"] = "[DB]",
						},
						maxwidth = 50, -- prevent the popup from showing more than provided characters
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
					}),
				},
				experimental = {
					-- I like the new menu better! Nice work hrsh7th
					native_menu = false,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<leader>z"] = cmp.mapping.complete(),
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
					-- ["<tab>"] = false,
					-- ["<tab>"] = cmp.config.disable,
					["<Tab>"] = cmp_action.luasnip_supertab(),
					["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
				}),
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "folke/neodev.nvim" },
		},
		config = function()
			-- This is where all the LSP shenanigans will live
			require("neodev").setup({})
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()
			lsp_zero.set_preferences({
				suggest_lsp_servers = false,
				sign_icons = {
					error = "E",
					warn = "W",
					hint = "H",
					info = "I",
				},
			})

			---@diagnostic disable-next-line: trailing-space

			---@diagnostic disable-next-line: unused-local
			lsp_zero.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }

				lsp_zero.default_keymaps({ buffer = bufnr })
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "<leader>ds", function()
					vim.lsp.buf.document_symbol()
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "<leader>dn", function()
					vim.diagnostic.goto_next()
				end, opts)
				vim.keymap.set("n", "<leader>dp", function()
					vim.diagnostic.goto_prev()
				end, opts)
				vim.keymap.set({ "v", "n" }, "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-s>", function()
					vim.lsp.buf.signature_help()
				end, opts)
			end)

			require("mason-lspconfig").setup({
				ensure_installed = {
					-- "groovyls",
					"gopls",
					"pylsp",
					"tsserver",
					"rust_analyzer",
					"yamlls",
					"terraformls",
					"lua_ls",
				},
				handlers = {
					lsp_zero.default_setup,
					gopls = function()
						require("lspconfig").gopls.setup({
							settings = {
								gopls = {
									hints = {
										assignVariableTypes = true,
										compositeLiteralFields = true,
										compositeLiteralTypes = true,
										constantValues = true,
										functionTypeParameters = true,
										parameterNames = true,
										rangeVariableTypes = true,
									},
								},
							},
						})
					end,

					lua_ls = function()
						-- (Optional) Configure lua language server for neovim
						require("lspconfig").lua_ls.setup({
							settings = {
								Lua = {
									completion = {
										callSnippet = "Replace",
									},
									hint = {
										enable = true,
										arrayIndex = "Disable",
									},
									diagnostic = {
										globals = { "vim" },
									},
									workspace = {
										library = { vim.env.VIMRUNTIME, vim.fn.stdpath("config") },
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}
