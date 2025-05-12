return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = "typespec" },
  },
  {
    "mason-org/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "tsp-server" } },
  },
}
