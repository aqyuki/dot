local formatter = {
  "prettier",
  "biome",
  stop_after_first = true,
}

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = formatter,
      javascriptreact = formatter,
      typescript = formatter,
      typescriptreact = formatter,
      css = formatter,
      scss = formatter,
      html = formatter,
    },
    formatters = {
      prettier = {
        condition = function()
          return not require("util.format").exist_biome_setting()
        end,
      },
      biome = {
        condition = function()
          local util = require("util.format")
          return util.exist_biome_setting() and not util.exist_prettier_setting()
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "prettier", "biome" })
    end,
  },
}
