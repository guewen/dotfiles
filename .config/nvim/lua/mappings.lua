require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- Function to copy the current file path to the clipboard
function CopyFilePath()
  local file_path = vim.fn.expand "%:."
  vim.fn.system("wl-copy", file_path)
  print("Copied file path: " .. file_path)
end

-- Function to copy the current file path and line number to the clipboard
function CopyFilePathAndLine()
  local file_path = vim.fn.expand "%:." .. ":" .. vim.fn.line "."
  vim.fn.system("wl-copy", file_path)
  print("Copied file path and line: " .. file_path)
end

-- Setting up the key mappings
vim.api.nvim_set_keymap("n", "<leader>fG", ":lua CopyFilePath()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ":lua CopyFilePathAndLine()<CR>", { noremap = true, silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<space>fE", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep_args<CR>", { noremap = true, silent = true })
vim.keymap.set(
  "n",
  "<leader>fW",
  '<cmd>Telescope live_grep_args search_dirs={"%:p:h"}<CR>',
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>f<space>",
  "<CMD>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>",
  { noremap = true, silent = true }
)

vim.keymap.set("n", "<leader>fd", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pd", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })

if vim.g.neovide then
  vim.api.nvim_set_keymap("v", "<sc-c>", '"+y', { noremap = true })
  vim.api.nvim_set_keymap("n", "<sc-v>", 'l"+P', { noremap = true })
  vim.api.nvim_set_keymap("v", "<sc-v>", '"+P', { noremap = true })
  vim.api.nvim_set_keymap("c", "<sc-v>", "<C-R>+", { noremap = true })
  vim.api.nvim_set_keymap("i", "<sc-v>", '<ESC>l"+Pli', { noremap = true })
  vim.api.nvim_set_keymap("t", "<sc-v>", '<C-\\><C-n>"+Pi', { noremap = true })

  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.02)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.02)
  end)
end

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>fe", "<CMD>Oil<CR>", { desc = "Open parent directory" })
