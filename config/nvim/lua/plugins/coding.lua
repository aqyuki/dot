return {
  {
    "stevearc/conform.nvim",
    opts = {
      lsp_format = "fallback",
      formatters_by_ft = {
        go = { "goimports" },
        rust = { "rustfmt" },
        json = { "prettier" },
        yaml = { "prettier" },
        toml = { "taplo" },
      },
    },
  },
}
