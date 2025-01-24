return {
  s("t", fmt("- [{}] {}", { c(2, { t(" "), t("-"), t("x") }), i(1, "task") })),
  postfix(".br", {
    f(function(_, parent)
      return "[" .. parent.snippet.env.POSTFIX_MATCH .. "]"
    end, {}),
  }),
  postfix(".brd", {
    d(1, function(_, parent)
      return sn(
        nil,
        fmt(
          [[
                <span style="{}"> {} </span>
                ]],
          { i(1), t(parent.env.POSTFIX_MATCH) }
        )
      )
    end),
  }),
  s(
    "sor",
    fmt(
      [[
            <span style="{style}">{finish}</span>
        ]],
      {
        style = i(1),
        finish = f(function(snip)
          local res, env = {}, snip.env
          print(env)
          table.insert(res, "Selected Text (current line is " .. env.TM_LINE_NUMBER .. "):")
          for _, ele in ipairs(env.LS_SELECT_RAW) do
            table.insert(res, ele)
          end
          return res
        end, {}),
      }
    )
  ),
  s({
    trig = "link",
    namr = "markdown_link",
    dscr = "Create markdown link [txt](url)",
  }, {
    t("["),
    i(1),
    t("]("),
    i(0),
    t(")"),
  }),
}
