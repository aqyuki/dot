return {
  {
    "folke/snacks.nvim",
    opts = {
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
    },
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
    "folke/which-key.nvim",
    opts = {
      spec = { { mode = "n", { "<localleader>t", group = "Terminal" } } },
    },
  },
}
