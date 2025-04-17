return {
  {
    "stevearc/conform.nvim",
    opts = {
      lsp_format = "fallback",
      formatters_by_ft = {
        rust = { "rustfmt" },
        json = { "prettier" },
        yaml = { "prettier" },
        toml = { "taplo" },
      },
    },
  },
}
