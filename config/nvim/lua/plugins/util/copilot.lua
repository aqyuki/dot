local function is_company_dir()
  local ghq_root = vim.fn.system("ghq root"):gsub("\n", "")
  local cwd = vim.loop.cwd()

  local patterns = {
    ghq_root .. "/github.com/yumemi",
    ghq_root .. "/github.com/yumemi-inc",
  }

  for _, pattern in ipairs(patterns) do
    if cwd:match("^" .. vim.pesc(pattern)) then
      return false
    end
  end
  return true
end

return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        providers = {
          copilot = {
            enabled = is_company_dir,
          },
        },
      },
    },
  },
}
