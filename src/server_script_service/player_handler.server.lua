-- Services
local server_script_service = game:GetService("ServerScriptService")
local replicated_storage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

-- Modules
local entity_factory = require(server_script_service.factories.entity_factory)
local entity_manager = require(server_script_service.managers.entity_manager)
local data_factory = require(server_script_service.factories.data_factory)
local data_manager = require(server_script_service.managers.data_manager)

-- Player Added
local function add_player(player)
    local player_data = data_manager.load_data(player.UserId) or data_factory.create_data()
    if not player_data then
        warn("Failed to create or load data for player: " .. player.Name)
        return
    end

    local entity = entity_factory.create_entity(player.Name, player_data)
    local entity_id = entity_manager.add_entity(entity)

    if not entity_id then
        warn("Failed to add entity for player: " .. player.Name)
        return
    end

    entity.id = entity_id
    entity.player_id = player.UserId
    player:SetAttribute("entity_id", entity_id)
end


-- Player Removing
local function remove_player(player)
    local entity_id = player:GetAttribute("entity_id")
    if not entity_id then
        warn("Player does not have a valid entity_id")
        return
    end

    local entity = entity_manager.get_entity(entity_id)
    if not entity then
        warn("No entity found for entity_id: " .. tostring(entity_id))
        return
    end

    data_manager.save_data(entity.player_id, entity.properties)
    entity_manager.remove_entity(entity_id)
end

-- Connect events
players.PlayerAdded:Connect(add_player)
players.PlayerRemoving:Connect(remove_player)
