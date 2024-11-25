-- Services
local server_script_service = game:GetService("ServerScriptService")
local players = game:GetService("Players")

-- Modules
local entity_factory = require(server_script_service.factories.entity_factory)
local entity_manager = require(server_script_service.managers.entity_manager)

-- Player Added
local function player_added(player)
    local entity = entity_factory.create_entity(player.Name, {player = player})
    local uuid = entity_manager.add_entity(entity) -- Add entity and get its UUID
    entity.id = uuid -- Store the UUID in the entity itself
    print("Entity created for player:", player.Name, "with UUID:", uuid)
end

-- Player Removing
local function player_removing(player)
    -- Find and remove the entity associated with this player
    for uuid, entity in pairs(entity_manager.get_all_entities()) do
        if entity.properties and entity.properties.player == player then
            entity_manager.remove_entity(uuid)
            break
        end
    end
end

-- Connect events
players.PlayerAdded:Connect(player_added)
players.PlayerRemoving:Connect(player_removing)
