return {
  "akinsho/toggleterm.nvim",
  opts = {
    open_mapping = "<localleader>tt",
    direction = "float",
    on_open = function(t)
      vim.keymap.set("t", "<Space>", "<Space>", { buffer = t.bufnr })
    end,
  },
}
