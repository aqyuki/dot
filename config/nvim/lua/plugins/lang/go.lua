return {
  {
    "stevearc/conform.nvim",
    go = { "goimports", "gci" },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "goimports", "gci" })
    end,
  },
}
