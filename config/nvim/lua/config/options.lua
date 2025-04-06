-- Encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- System integration
vim.opt.shell = "fish"
vim.opt.clipboard = "unnamedplus"

-- Diagnostic
vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
  },
})
