return {
  -- { import = "nvchad.blink.lazyspec" },
  --
  -- {
  --   "Saghen/blink.cmp",
  --   opts = {
  --     keymap = {
  --       preset = "none",
  --
  --       ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  --       ["<C-e>"] = { "hide", "fallback" },
  --       ["<CR>"] = { "accept", "fallback" },
  --
  --       ["<Up>"] = { "select_prev", "fallback" },
  --       ["<Down>"] = { "select_next", "fallback" },
  --       ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
  --       ["<C-n>"] = { "select_next", "fallback_to_mappings" },
  --
  --       ["<C-b>"] = { "scroll_documentation_up", "fallback" },
  --       ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  --
  --       ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
  --     },
  --   },
  -- },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
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
      incremental_selection = {
        enable = true,
        keymaps = {
          -- init_selection = "<C-o>",
          node_incremental = "v",
          -- scope_incremental = "<C-O>",
          node_decremental = "V",
        },
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

  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup {
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --     }
  --   end,
  -- },
  --
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  {
    "nvim-telescope/telescope-frecency.nvim",
    version = "*",
    config = function()
      require("telescope").load_extension "frecency"
    end,
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
      overwrite = {
        search = {
          enabled = true,
        },
        undo = {
          enabled = true,
        },
        redo = {
          enabled = true,
        },
      },
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

  {
    "tpope/vim-obsession",
    lazy = false,
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
