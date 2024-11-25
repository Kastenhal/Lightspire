-- Services
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

-- Modules
local EntityFactory = require(ServerScriptService.factories.entity_factory)
local EntityManager = require(ServerScriptService.managers.entity_manager)

-- Player Added
local function player_added(player)
    local entity = EntityFactory.create_entity(player.Name, {player = player})
    local uuid = EntityManager.add_entity(entity) -- Add entity and get its UUID
    entity.id = uuid -- Store the UUID in the entity itself
    print("Entity created for player:", player.Name, "with UUID:", uuid)
end

-- Player Removing
local function player_removing(player)
    -- Find and remove the entity associated with this player
    for uuid, entity in pairs(EntityManager.get_all_entities()) do
        if entity.properties and entity.properties.player == player then
            EntityManager.remove_entity(uuid)
            break
        end
    end
end

-- Connect events
Players.PlayerAdded:Connect(player_added)
Players.PlayerRemoving:Connect(player_removing)
