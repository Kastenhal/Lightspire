-- data.lua
local data = {}

-- Creates a new data object
function data.new()
    local self = setmetatable({}, data)
    self.triumphs = 0
    self.last_login = nil
    return self
end

return data