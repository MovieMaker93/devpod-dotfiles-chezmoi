-- Formatting.
return {
	{
		"stevearc/conform.nvim",
		event = { "LspAttach", "BufWritePre" },
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				go = { "goimports", "gofmt", "golines" },
				yaml = { "yamlfmt", "prettier" },
				just = { "just" },
				rust = { "rustfmt" },
				json = { "prettier" },
				css = { "prettier" },
				markdown = { "prettier" },
				tf = { "tflint" },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		},
		-- init = function()
		--     -- Use conform for gq.
		--     vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		--
		--     -- Configure format on save inside my dotfiles and personal projects.
		--     vim.api.nvim_create_autocmd('BufEnter', {
		--         desc = 'Configure format on save',
		--         callback = function(args)
		--             local path = vim.api.nvim_buf_get_name(args.buf)
		--             path = vim.fs.normalize(path)
		--             vim.b[args.buf].format_on_save = vim.iter({ vim.env.XDG_CONFIG_HOME, vim.g.personal_projects_dir })
		--                 :any(function(folder)
		--                     return vim.startswith(path, vim.fs.normalize(folder))
		--                 end)
		--         end,
		--     })
		-- end,
	},
}
