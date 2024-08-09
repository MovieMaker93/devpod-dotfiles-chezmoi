local mason_tool_installer = require("mason-tool-installer")
mason_tool_installer.setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"goimports",
		"golines",
		"yamlfmt",
		"rustfmt",
		"shfmt",
	},
	run_on_start = true,
})
