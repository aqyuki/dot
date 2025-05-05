return {
  {
    "Shatur/neovim-ayu",
    lazy = true,
    opts = {
      terminal = true,
    },
    config = function(_, opts)
      require("ayu").setup(opts)
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {},
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
    },
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    opts = {
      transparent = false,
    },
  },
}
