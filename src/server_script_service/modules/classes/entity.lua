-- functions

-- Generates a UUID
local function generate_uuid(): string
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"

    local uuid = string.gsub(template, "[xy]", function(c)
        local v = (c == "x") and math.random(0, 15) or math.random(8, 11)
        return string.format("%x", v)
    end)

    return uuid
end

-- entity.lua
local entity = {}
entity.__index = entity

-- Creates a new entity
function entity.new()
    local self = setmetatable({}, entity)
    self.uuid = generate_uuid()
    return self
end

-- Destroys an entity
function entity:destroy()
    self = nil
end

return entity
