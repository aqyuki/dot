-- LazyVim settings
vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_cmp = "blink.cmp"
vim.g.lazyvim_blink_main = true
vim.g.lazyvim_mini_snippets_in_completion = true

-- Spell check
vim.opt.spelllang = { "cjk", "en" }

-- File
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = false
vim.opt.autoread = true

-- Encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- System integration
vim.opt.shell = "fish"
vim.opt.clipboard = { "unnamedplus", "unnamed" }

-- Diagnostic
vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
  },
})
