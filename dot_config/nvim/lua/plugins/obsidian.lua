return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	--   "BufReadPre path/to/my-vault/**.md",
	--   "BufNewFile path/to/my-vault/**.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		ui = { enable = false },
		workspaces = {
			{
				name = "personal",
				path = "$VAULT",
			},
		},
		notes_subdir = "Inbox",
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "002 journal",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%d-%m-%Y",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			alias_format = "%B %-d, %Y",
			-- Optional, default tags to add to each new daily note created.
			default_tags = { "dailies" },
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = "Templater/Daily Note",
		},
		new_notes_location = "notes_subdir",

		-- Optional, boolean or a function that takes a filename and returns a boolean.
		-- `true` indicates that yjdou don't want obsidian.nvim to manage frontmatter.
		disable_frontmatter = true,
		-- Optional, customize how note IDs are generated given an optional title.
		---@param title string|?
		---@return string
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will be given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return suffix
		end,
		templates = {
			folder = "Templates",
			date_format = "%d-%m-%Y",
			time_format = "%H:%M",
		},
		-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
		-- URL it will be ignored but you can customize this behavior here.
		---@param url string
		follow_url_func = function(url)
			-- Open the URL in the default web browser.
			-- vim.fn.jobstart({"open", url})  -- Mac OS
			vim.fn.jobstart({ "xdg-open", url }) -- linux
			-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
			-- vim.ui.open(url) -- need Neovim 0.10.0+
		end,
		-- see below for full list of options 👇
	},
}
