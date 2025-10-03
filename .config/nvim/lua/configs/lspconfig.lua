--
-- load defaults i.e lua_lsp
--
require("nvchad.configs.lspconfig").defaults()

-- local lsp_configurations = require "lspconfig.configs"
-- lsp_configurations.odoo_lsp = {
--   default_config = {
--     name = "odoo-lsp",
--     cmd = { "odoo-lsp" },
--     filetypes = { "javascript", "xml", "python" },
--     root_dir = require("lspconfig.util").root_pattern(".odoo_lsp", ".odoo_lsp.json"),
--   },
-- }
--

local function odoo_ls()
  local server = "odoo_ls_server"
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.general.markdown = {
    parser = "marked",
    version = "",
  }
  return {
    cmd = {
      server,
      "--stdlib",
      "/home/guewenb/sources/typeshed/stdlib",
    },
    --root_dir = "/home/guewenb/.local/share/nvim/odoo",
    filetypes = { "python", "xml" },
    -- workspace_folders = { {
    --   uri = vim.uri_from_fname "/home/whe/src",
    --   name = "main_folder",
    -- } },
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
  odoo_lsp = {},
  pyright = {},
  dockerls = {},
  yamlls = {},
  ts_ls = {},
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
