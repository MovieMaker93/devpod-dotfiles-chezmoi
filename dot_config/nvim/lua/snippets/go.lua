return {
	s("gom", fmt("func main(){{ \n {} \n }}", { i(1, "printf()") })),
	s(
		"ger",
		fmta(
			[[
        <val>,<err> := <f>(<args>)
        if <err_same> != nil {
            return err
        }
        <finish>
        ]],
			{
				val = i(1),
				err = i(2, "err"),
				f = i(3),
				args = i(4),
				err_same = rep(2),
				finish = i(0),
			}
		)
	),
}
