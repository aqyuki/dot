return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = "typespec" },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "tsp-server" } },
  },
}
