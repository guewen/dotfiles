--
-- load defaults i.e lua_lsp
--
require("nvchad.configs.lspconfig").defaults()

local function odoo_ls()
  local server = "odoo_ls_server" -- odoo_ls_server is installed under ~/bin/odoo_ls_server
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
  capabilities.textDocument.hover.contentFormat = { "markdown", "plaintext" }
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return {
    cmd = {
      server,
      "--stdlib",
      "/home/guewenb/sources/typeshed/stdlib",
    },
    root_markers = { "odools.toml" },
    filetypes = { "python", "xml", "csv" },
    capabilities = capabilities,
    settings = {
      Odoo = {
        selectedProfile = "main",
      },
    },
  }
end

local servers = {
  odoo_ls = odoo_ls(),
  html = {},
  cssls = {},
  awk_ls = {},
  bashls = {},
  rubocop = {
    cmd = { "bundle", "exec", "rubocop", "--lsp" },
    filetypes = { "ruby" },
    root_markers = { ".rubocop.yml" },
  },
  ruby_lsp = {},
  sorbet = {
    cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
    filetypes = { "ruby" },
    root_markers = { "sorbet" },
  },
  pyright = {},
  dockerls = {},
  yamlls = {},
  ts_ls = {},
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
