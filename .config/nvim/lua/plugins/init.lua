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

  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
  },

  {
    "nvim-telescope/telescope-symbols.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
  },

  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },

  {
    "Bekaboo/dropbar.nvim",
    lazy = false,
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },

  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-rhubarb",
    },
  },

  {
    "tpope/vim-abolish",
    lazy = false,
  },

  {
    "daliusd/ghlite.nvim",
    dependencies = {
      "sindrets/diffview.nvim",
    },
    config = function()
      require("ghlite").setup {
        debug = false, -- if set to true debugging information is written to ~/.ghlite.log file
        view_split = "vsplit", -- set to empty string '' to open in active buffer
        diff_split = "vsplit", -- set to empty string '' to open in active buffer
        comment_split = "split", -- set to empty string '' to open in active buffer
        open_command = "open", -- open command to use, e.g. on Linux you might want to use xdg-open
        keymaps = { -- override default keymaps with the ones you prefer
          diff = {
            open_file = "gf",
            open_file_tab = "gt",
            open_file_split = "gs",
            open_file_vsplit = "gv",
            approve = "<C-A>",
          },
          comment = {
            send_comment = "<C-CR>",
          },
          pr = {
            approve = "<C-A>",
          },
        },
      }
    end,
    keys = {
      { "<leader>us", ":GHLitePRSelect<cr>", silent = true },
      { "<leader>uo", ":GHLitePRCheckout<cr>", silent = true },
      { "<leader>uv", ":GHLitePRView<cr>", silent = true },
      { "<leader>uu", ":GHLitePRLoadComments<cr>", silent = true },
      { "<leader>up", ":GHLitePRDiff<cr>", silent = true },
      { "<leader>ul", ":GHLitePRDiffview<cr>", silent = true },
      { "<leader>ua", ":GHLitePRAddComment<cr>", silent = true },
      { "<leader>uc", ":GHLitePRUpdateComment<cr>", silent = true },
      { "<leader>ud", ":GHLitePRDeleteComment<cr>", silent = true },
      { "<leader>ug", ":GHLitePROpenComment<cr>", silent = true },
    },
  },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10,
    opts = {
      -- your configuration
    },
  },

  {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
  },

  -- {
  --   "chrisgrieser/nvim-early-retirement",
  --   event = "VeryLazy",
  --   config = function()
  --     require("early-retirement").setup {
  --       -- If a buffer has been inactive for this many minutes, close it.
  --       retirementAgeMins = 120,
  --
  --       -- Minimum number of open buffers for auto-closing to become active. E.g.,
  --       -- by setting this to 4, no auto-closing will take place when you have 3
  --       -- or fewer open buffers. Note that this plugin never closes the currently
  --       -- active buffer, so a number < 2 will effectively disable this setting.
  --       minimumBufferNum = 6,
  --
  --       -- When a file is deleted, for example via an external program, delete the
  --       -- associated buffer as well. Requires Neovim >= 0.10.
  --       -- (This feature is independent from the automatic closing)
  --       deleteBufferWhenFileDeleted = true,
  --     }
  --   end,
  -- },
}
