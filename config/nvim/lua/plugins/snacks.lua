-- `snacks.lua` extends LazyVim's snacks configuration.

return {
  "snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
        },
        files = {
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
