local formatter = function(_)
  local util = require("util.format")

  if util.exist_biome_setting() then
    return { "biome" }
  end

  if util.exist_prettier_setting() and not util.exist_biome_setting() then
    return { "prettier" }
  end

  return { "prettier" }
end

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
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "prettier", "biome" })
    end,
  },
}
