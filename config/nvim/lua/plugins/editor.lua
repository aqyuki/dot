return {
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      bigfile = { enabled = true },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
          files = {
            hidden = true,
          },
        },
      },
      quickfile = { enabled = true },
    },
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = {
      options = {
        separator_style = "slant",
      },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "LazyFile",
    opts = {
      handlers = {
        gitsigns = true,
        search = true,
      },
    },
  },
  {
    "mvllow/modes.nvim",
    event = "BufEnter",
    opts = {},
  },
  {
    "kevinhwang91/nvim-hlslens",
    dependencies = { "petertriho/nvim-scrollbar" },
    event = { { event = "CmdlineEnter", pattern = "/" } },
    opts = {},
    config = function(_, opts)
      require("scrollbar.handlers.search").setup(opts)
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
      { mode = "n", "<localleader>tn", ":TermNew<CR>", desc = "Create new terminal" },
      { mode = "n", "<localleader>ts", ":TermSelect<CR>", desc = "Select new terminal" },
    },
    opts = {
      open_mapping = "<localleader>tt",
      direction = "float",
      on_open = function(t)
        vim.keymap.set("t", "<Space>", "<Space>", { buffer = t.bufnr })
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = { { mode = "n", { "<localleader>t", group = "Terminal" } } },
    },
  },
}
