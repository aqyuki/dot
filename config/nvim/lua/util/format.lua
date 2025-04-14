---@class FormatterConfigChecker
local M = {}

---Check if any of the specified files exist in the current working directory
---@param files string[] List of filenames to check for existence
---@return boolean True if any file exists in the current working directory
local function find_file_in_root(files)
  local cwd = vim.fn.getcwd()

  for _, file in ipairs(files) do
    local path = cwd .. "/" .. file
    if vim.fn.filereadable(path) == 1 then
      return true
    end
  end
  return false
end

---Check if the biome configuration file exists in the project root
---@return boolean True if 'biome.json' exists in the current working directory
function M.exist_biome_setting()
  local files = { "biome.json" }
  return find_file_in_root(files)
end

---Check if a Prettier configuration file exists in the project root
---@return boolean True if any Prettier config file exists in the current working directory
function M.exist_prettier_setting()
  local files = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.js",
    ".prettierrc.cjs",
  }
  return find_file_in_root(files)
end

return M
