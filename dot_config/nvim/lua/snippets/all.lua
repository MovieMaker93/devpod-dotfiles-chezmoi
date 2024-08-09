local snippets, autosnippets = {}, {}
snippets[#snippets + 1] = s("simple", t("wow, you were right!"))
snippets[#snippets + 1] = s({ trig = "date" }, {
	f(function()
		return string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), os.date())
	end, {}),
})
return snippets, autosnippets
