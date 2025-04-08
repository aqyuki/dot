-- LazyVim settings
vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_cmp = "blink.cmp"

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
