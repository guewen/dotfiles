-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

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
  ruby_lsp = {
    cmd = { "~/.rbenv/shims/ruby-lsp" },
    filetypes = { "ruby" },
    root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
  },
  sorbet = {
    cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
    filetypes = { "ruby" },
    root_dir = lspconfig.util.root_pattern "sorbet/config",
  },
  pyright = {},
  dockerls = {},
  yamlls = {},
  tsserver = {},
}

local nvlsp = require "nvchad.configs.lspconfig"

for name, opts in pairs(servers) do
  opts.on_init = nvlsp.on_init
  opts.on_attach = nvlsp.on_attach
  opts.capabilities = nvlsp.capabilities

  require("lspconfig")[name].setup(opts)
end

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
