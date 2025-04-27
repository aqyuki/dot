--- @class DirUtil
local M = {}

---  @param parent string
---  @param target string
---  @return boolean
M.is_child = function(parent, target)
  return target:match("^" .. vim.pesc(parent))
end

return M
