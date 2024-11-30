-- services
local server_script_service = game:GetService("ServerScriptService")
local replicated_storage = game:GetService("ReplicatedStorage")

-- classes
local entity = require(server_script_service.modules.classes.entity)

-- folders
local remotes = replicated_storage:FindFirstChild("remotes")

-- entity_manager.lua
local entity_manager = {}
entity_manager.__index = entity_manager

entity_manager.entities = {}

-- Creates a new entity
function entity_manager.create_entity(): table
    local entity = entity.new()
    entity_manager.entities[entity.uuid] = entity

    return entity
end

-- Retrieves an entity by UUID
function entity_manager.get_entity(uuid: string): table
    if entity_manager.entities[uuid] then
        return entity_manager.entities[uuid]
    end
end

-- Destroys an entity by UUID
function entity_manager.destroy_entity(uuid: string): nil
    local entity = entity_manager.entities[uuid]
    entity_manager.entities[uuid] = nil
    entity:destroy()
end

return entity_manager