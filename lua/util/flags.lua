local cache = {}

local function _env_flag_enabled(env_var)
  local value = os.getenv(env_var)
  if value == nil then
    return false
  end

  value = value:lower()
  return value == "1" or value == "true" or value == "yes"
end

local function env_flag_enabled(env_var)
  if cache[env_var] == nil then
    cache[env_var] = _env_flag_enabled(env_var)
  end
  return cache[env_var]
end

return {
  use_local_ai = function()
    return env_flag_enabled("NVIM_USE_LOCAL_AI")
  end,
}
