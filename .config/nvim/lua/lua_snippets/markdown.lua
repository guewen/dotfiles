local ls = require "luasnip"

ls.add_snippets("markdown", {
  ls.snippet("changelog", {
    ls.text_node "[",
    ls.function_node(function()
      return vim.fn.expand "%:t:r"
    end),
    ls.text_node "](https://qoqach.atlassian.net/browse/",
    ls.function_node(function()
      return vim.fn.expand "%:t:r"
    end),
    ls.text_node ") ",
    ls.insert_node(1),
  }),
})

