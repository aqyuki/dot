local web_formatter = {
  "prettier",
}

return {
  {
    "stevearc/conform.nvim",
    opts = {
      lsp_format = "fallback",
      formatters_by_ft = {
        go = { "goimports" },
        rust = { "rustfmt" },
        javascript = web_formatter,
        javascriptreact = web_formatter,
        typescript = web_formatter,
        typescriptreact = web_formatter,
        css = web_formatter,
        scss = web_formatter,
        html = web_formatter,
        json = { "prettier" },
        yaml = { "prettier" },
        toml = { "taplo" },
      },
    },
  },
}
