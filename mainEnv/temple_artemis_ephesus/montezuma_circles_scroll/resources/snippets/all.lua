local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("all", {
	s("d", { t("$") })
})


ls.add_snippets("all", {
	s("ddd", { t("this b what i b inserting") })
})
