-- Services
local server_script_service = game:GetService("ServerScriptService")
local replicated_storage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

-- Modules
local entity_factory = require(server_script_service.factories.entity_factory)
local entity_manager = require(server_script_service.managers.entity_manager)
local data_factory = require(server_script_service.factories.data_factory)
local data_manager = require(server_script_service.managers.data_manager)

-- Folders
local remotes = replicated_storage.remotes

-- Player Added
local function player_added(player)
    local data = data_manager.load_data(player.UserId) or data_factory.create_data()
    local entity = entity_factory.create_entity(player.Name, data)
    local uuid = entity_manager.add_entity(entity) -- Add entity and get its UUID
    entity.id = uuid -- Store the UUID in the entity itself
    entity.player_id = player.UserId

    player:SetAttribute("entity_id", uuid)
end

-- Player Removing
local function player_removing(player)
    local entity_id = player:GetAttribute("entity_id")
    local entity = entity_manager.get_entity(entity_id)
    data_manager.save_data(entity.player_id, entity.properties)
    entity_manager.remove_entity(entity.id)
end

-- Connect events
players.PlayerAdded:Connect(player_added)
players.PlayerRemoving:Connect(player_removing)
