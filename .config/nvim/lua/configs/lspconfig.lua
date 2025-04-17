-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local lsp_configurations = require "lspconfig.configs"
lsp_configurations.odoo_lsp = {
  default_config = {
    name = "odoo-lsp",
    cmd = { "odoo-lsp" },
    filetypes = { "javascript", "xml", "python" },
    root_dir = require("lspconfig.util").root_pattern(".odoo_lsp", ".odoo_lsp.json"),
  },
}

local servers = {
  html = {},
  cssls = {},
  awk_ls = {},
  bashls = {},
  rubocop = {
    cmd = { "bundle", "exec", "rubocop", "--lsp" },
    filetypes = { "ruby" },
    root_dir = lspconfig.util.root_pattern ".rubocop.yml",
  },
  ruby_lsp = {},
  sorbet = {
    cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
    filetypes = { "ruby" },
    root_dir = lspconfig.util.root_pattern "sorbet/config",
  },
  odoo_lsp = {},
  pyright = {},
  dockerls = {},
  yamlls = {},
  ts_ls = {},
}

local nvlsp = require "nvchad.configs.lspconfig"

for name, opts in pairs(servers) do
  opts.on_init = nvlsp.on_init
  opts.on_attach = nvlsp.on_attach
  opts.capabilities = nvlsp.capabilities

  lspconfig[name].setup(opts)
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
