local function is_company_dir()
  local dir_util = require("utils.dir")
  local ghq_root = vim.fn.system("ghq root"):gsub("\n", "")
  local company_dir = {
    ghq_root .. "/github.com/yumemi",
    ghq_root .. "/github.com/yumemi-inc",
  }

  local cwd = vim.uv.cwd()
  if cwd == nil then
    return false
  end

  for _, pattern in ipairs(company_dir) do
    if dir_util.is_child(pattern, cwd) then
      return false
    end
  end
  return true
end

return {
  {
    "github/copilot.vim",
    lazy = true,
    event = "BufReadPost",
    cmd = "Copilot",
    cond = is_company_dir(),
  },
}
