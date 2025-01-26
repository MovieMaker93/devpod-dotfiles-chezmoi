return {
	"saghen/blink.cmp",
	enabled = true,
	tag = "v0.10.0", -- Replace with a specific tag version
	dependencies = {
		"moyiz/blink-emoji.nvim",
	},
	opts = function(_, opts)
		-- Merge custom sources with the existing ones from lazyvim
		-- NOTE: by default lazyvim already includes the lazydev source, so not
		-- adding it here again
		opts.enabled = function()
			-- Get the current buffer's filetype
			local filetype = vim.bo[0].filetype
			-- Disable for Telescope buffers
			if filetype == "TelescopePrompt" or filetype == "minifiles" then
				return false
			end
			return true
		end

		opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
			default = { "lsp", "path", "snippets", "buffer", "emoji" },
			providers = {
				lsp = {
					name = "lsp",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					-- When linking markdown notes, I would get snippets and text in the
					-- suggestions, I want those to show only if there are no LSP
					-- suggestions
					-- fallbacks = { "snippets", "luasnip", "buffer" },
					score_offset = 90, -- the higher the number, the higher the priority
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 25,
					-- When typing a path, I would get snippets and text in the
					-- suggestions, I want those to show only if there are no path
					-- suggestions
					fallbacks = { "snippets", "buffer" },
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},
				buffer = {
					name = "Buffer",
					enabled = true,
					max_items = 5,
					min_keyword_length = 3,
					module = "blink.cmp.sources.buffer",
					score_offset = 15, -- the higher the number, the higher the priority
				},
				snippets = {
					name = "snippets",
					enabled = true,
					max_items = 8,
					min_keyword_length = 2,
					module = "blink.cmp.sources.snippets",
					score_offset = 85, -- the higher the number, the higher the priority
				},
				emoji = {
					module = "blink-emoji",
					name = "Emoji",
					score_offset = 15, -- the higher the number, the higher the priority
					opts = { insert = true }, -- Insert emoji (default) or complete its name
				},
			},
			cmdline = function()
				local type = vim.fn.getcmdtype()
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				if type == ":" then
					return { "cmdline" }
				end
				return {}
			end,
		})

		opts.completion = {
			--   keyword = {
			--     -- 'prefix' will fuzzy match on the text before the cursor
			--     -- 'full' will fuzzy match on the text before *and* after the cursor
			--     -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
			--     range = "full",
			--   },
			menu = {
				border = "single",
			},
			documentation = {
				auto_show = true,
				window = {
					border = "single",
				},
			},
			-- Displays a preview of the selected item on the current line
			ghost_text = {
				enabled = true,
			},
		}

		-- This comes from the luasnip extra, if you don't add it, won't be able to
		-- jump forward or backward in luasnip snippets
		-- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
		opts.snippets = {
			preset = "luasnip",
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		}

		-- The default preset used by lazyvim accepts completions with enter
		-- I don't like using enter because if on markdown and typing
		-- something, but you want to go to the line below, if you press enter,
		-- the completion will be accepted
		-- https://cmp.saghen.dev/configuration/keymap.html#default
		opts.keymap = {
			preset = "default",
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
		}
		opts.signature = {
			enabled = true,
		}

		return opts
	end,
}
