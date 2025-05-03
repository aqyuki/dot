return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = "typespec" },
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "tsp-server" } },
  },
}
