local M = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {"groovy", "markdown", "markdown_inline", "java", "lua", "vim", "vimdoc", "query", "javascript", "html", "yaml", "rust", "go", "json" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end}

return { M }
