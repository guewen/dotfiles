require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!

if vim.g.neovide then
  vim.o.guifont = "Source Code Pro:h11.5"
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
end

local telescope = require "telescope"
telescope.load_extension "file_browser"
telescope.load_extension "dir"

local lga_actions = require "telescope-live-grep-args.actions"

telescope.setup {
  defaults = {
    winblend = 30,
    mappings = {
      i = {
        ["<C-space>"] = require("telescope.actions").to_fuzzy_refine,
      },
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
          -- freeze the current list and start a fuzzy search in the frozen list
          ["<C-space>"] = require("telescope.actions").to_fuzzy_refine,
        },
      },
    },
  },
}

telescope.load_extension "live_grep_args"

vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/lua_snippets"

vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

require("conform").setup {
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
}

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
