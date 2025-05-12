return {
  -- 言語毎の設定はcore/lang配下に配置する
  { import = "core.lang" },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        toml = { "taplo" },
        rust = { "rustfmt" },
      },
    },
  },
  {
    "Wansmer/treesj",
    keys = {
      {
        mode = "n",
        "<leader>cj",
        function()
          require("treesj").toggle()
        end,
        desc = "toggle by TreeSJ",
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
