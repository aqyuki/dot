return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "gci" },
      },
      formatters = {
        gci = {
          command = "gci",
          args = { "write", "$FILENAME" },
          stdin = false,
          inhert = false,
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gci" })
    end,
  },
}
