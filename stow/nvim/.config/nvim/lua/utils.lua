local Module = {}

-- Require an entire directory relative to the config path of Neovim.
Module.require_dir_from_config = function(path)
  -- Not foolproof logic. Too bad!
  if string.sub(path, string.len(path)) ~= "/" then
    path = path .. "/"
  end
  if string.sub(path, 0, 1) ~= "/" then
    path = "/" .. path
  end
  path = vim.fn.stdpath("config") .. path
  local files = vim.split(vim.fn.glob(path .. "*"), "\n", { trimempty = true })
  for _, filepath in ipairs(files) do
    if string.match(filepath, ".lua$") then
      local reqstr = string.gsub(filepath, "^" .. vim.fn.stdpath("config") .. "/lua/", "")
      reqstr = string.gsub(string.gsub(reqstr, "/", "."), ".lua$", "")
      -- print(reqstr)
      require(reqstr)
    end
  end
end

return Module
