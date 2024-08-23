return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "markdown",
        "markdown_inline",
        "ruby",
        "python",
        "rust",
        "yaml",
        "json",
        "sql",
      },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- disable tab in cmp so it is available for copilot
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        -- disable  tab
        ["<Tab>"] = function(callback)
          callback()
        end,

        ["<S-Tab>"] = function(callback)
          callback()
        end,
      },
    },
  },

  {
    "github/copilot.vim",
    lazy = false,
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  {
    "princejoogie/dir-telescope.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("dir-telescope").setup {
        -- these are the default options set
        hidden = true,
        no_ignore = false,
        show_preview = true,
      }
    end,
  },

  -- {
  --   "Isrothy/neominimap.nvim",
  --   enabled = true,
  --   lazy = false, -- NOTE: NO NEED to Lazy load
  --   -- Optional
  --   keys = {
  --     { "<leader>nt", "<cmd>Neominimap toggle<cr>", desc = "Toggle minimap" },
  --     { "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable minimap" },
  --     { "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable minimap" },
  --     { "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
  --     { "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
  --     { "<leader>ns", "<cmd>Neominimap toggleFocus<cr>", desc = "Toggle focus on minimap" },
  --     { "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
  --     { "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
  --     { "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
  --     { "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },
  --     { "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
  --     { "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
  --     { "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
  --     { "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },
  --   },
  --   init = function()
  --     vim.opt.wrap = false -- Recommended
  --     vim.opt.sidescrolloff = 36 -- It's recommended to set a large value
  --     ---@type Neominimap.UserConfig
  --     vim.g.neominimap = {
  --       auto_enable = true,
  --     }
  --   end,
  -- },

  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },

  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
}
