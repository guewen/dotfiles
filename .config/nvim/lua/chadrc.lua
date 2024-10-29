-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",

  -- hl_override = {
  --   Comment = { italic = true },
  --   ["@comment"] = { italic = true },
  -- },
  --
  hl_override = {
    Comment = { fg = "#9aa2be" },
    ["@comment"] = { fg = "#9aa2be" },
  },
}

return M
