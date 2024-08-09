local nvim_lsp = require("lspconfig")
require("lspconfig").groovyls.setup({
	filetypes = { "groovy" },
	cmd = {
		"/home/moviemaker/.local/share/nvim/mason/packages/groovy-language-server/groovy-language-server",
	},
	root_dir = nvim_lsp.util.root_pattern(".git", ".git/", "build.gradle", "pom.xml"),
})
