return {
  s(
    "req",
    fmt([[local {} = require("{}")]], {
      d(2, function(args, _)
        local ls = require("luasnip")
        local snippet_from_nodes = ls.sn
        local t = ls.text_node
        local c = ls.choice_node
        local text = args[1][1] or ""
        local split = vim.split(text, ".", { plain = true })

        local options = {}
        for len = 0, #split - 1 do
          table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
        end

        return snippet_from_nodes(nil, {
          c(1, options),
        })
      end, { 1 }),
      i(1),
    })
  ),
}
