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

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.rb",
--   callback = function()
--     vim.lsp.buf.format {
--       timeout_ms = 1000,
--       filter = function(client)
--         return client.name ~= "rubocop"
--       end,
--     }
--   end,
-- })
--

vim.api.nvim_create_autocmd("BufNewFile", {
  group = vim.api.nvim_create_augroup("FileWithLine", { clear = true }),
  pattern = "*",
  callback = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local filename, line_num = buf_name:match "^(.*):(%d+)$"

    if filename and line_num and vim.fn.filereadable(filename) == 1 then
      local bad_buf = vim.api.nvim_get_current_buf()

      -- Defer execution to allow Neovim to handle swap-file prompts safely
      -- This avoids issues when the file already exists and has a swap file
      vim.schedule(function()
        vim.cmd("edit " .. filename)

        -- Move cursor to the line
        -- (0 is the current buffer, line_num is 1-indexed, col is 0-indexed)
        pcall(vim.api.nvim_win_set_cursor, 0, { tonumber(line_num), 0 })

        vim.cmd "normal! zz"

        -- Clean up the ghost buffer "file:line"
        if vim.api.nvim_buf_is_valid(bad_buf) then
          vim.api.nvim_buf_delete(bad_buf, { force = true })
        end
      end)
    end
  end,
})
