local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    python = { "isort", "black" },
    ruby = { "rubocop" },
    rust = { "rustfmt" },
    typescript = { "eslint" },
  },

  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 1000, lsp_format = "fallback" }
  end,

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 1000,
  --   lsp_fallback = true,
  -- },

  formatters = {
    rubocop = {
      command = "bundle exec rubocop",
      args = { "-a", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" },
    },
  },
}

return options
