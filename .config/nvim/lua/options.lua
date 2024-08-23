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

telescope.setup {
  defaults = {
    winblend = 30,
  },
}

vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/lua_snippets"
