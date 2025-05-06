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
  -- LazyVimがMason v2.0に対応するまでバージョンを固定
  {
    "mason-org/mason.nvim",
    optional = true,
    version = "1.11.0",
    pin = true,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    optional = true,
    version = "1.32.0",
    pin = true,
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
