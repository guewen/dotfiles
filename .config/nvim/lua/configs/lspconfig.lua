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
  -- odoo_ls = odoo_ls(),
  odoo_ls = {
    cmd = { "odoo_ls_server", "--stdlib", "/home/guewenb/sources/typeshed/stdlib" },
    root_markers = { "odools.toml" },
    filetypes = { "python", "xml", "csv" },
  },
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
    root_markers = { ".rubocop.yml" },
  },
  ruff = {},
  basedpyright = {
    settings = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
      basedpyright = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "standard",
        analysis = {
          -- ruff (F401/F841/F821/F811) already covers these, avoid duplicate diagnostics
          diagnosticSeverityOverrides = {
            reportUnusedImport = "none",
            reportUnusedVariable = "none",
            reportUndefinedVariable = "none",
            reportRedeclaration = "none",
          },
        },
      },
    },
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = "openFilesOnly",
      useLibraryCodeForTypes = true,
    },
    handlers = {
      ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        if result and result.diagnostics then
          local filtered = {}
          for _, d in ipairs(result.diagnostics) do
            -- I want to hide baselined "hints"
            if not (d.message and d.message:match "^Baselined:") then
              table.insert(filtered, d)
            end
          end
          result.diagnostics = filtered
        end
        vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
      end,
    },
  },
  dockerls = {},
  yamlls = {},
  ts_ls = {},
  -- https://github.com/supabase-community/postgres-language-server?tab=readme-ov-file
  postgres_lsp = {},
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
