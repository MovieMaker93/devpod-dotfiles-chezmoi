vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- local lspconfig = require("lspconfig")
--
-- lspconfig.lua_ls.setup({
-- 	settings = {
-- 		Lua = {
-- 			-- runtime = {
-- 			-- 	version = "LuaJIT",
-- 			-- },
-- 			hint = {
-- 				enable = true,
-- 				arrayIndex = "Disable",
-- 			},
-- 			diagnostics = {
-- 				-- Get the language server to recognize the `vim` global
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				-- Make the server aware of Neovim runtime files and plugins
-- 				library = { vim.env.VIMRUNTIME },
-- 				checkThirdParty = false,
-- 			},
-- 			completion = {
-- 				callSnippet = "Replace",
-- 			},
-- 		},
-- 	},
-- })
