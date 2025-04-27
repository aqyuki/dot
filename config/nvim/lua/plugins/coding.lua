return {
  -- 言語毎の設定はcore/lang配下に配置する
  { import = "core.lang" },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        toml = { "taplo" },
        rust = { "rustfmt" },
      },
    },
  },
}
