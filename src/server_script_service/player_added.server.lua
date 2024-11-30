-- services
local server_script_service = game:GetService("ServerScriptService")
local players = game:GetService("Players")

-- modules
local entity_manager = require(server_script_service.modules.managers.entity_manager)
local data_manager = require(server_script_service.modules.managers.data_manager)

-- player_added.server.lua

-- Handles a player joining
local function player_added(player: Player): nil
    local entity = entity_manager.create_entity()
    player:SetAttribute("uuid", entity.uuid)
    print("Player", player, "joined.")

    local player_data = data_manager.load_data(player.UserId)
    if player_data then
        print("Data loaded for player:", player, player_data)
    else
        print("No existing data found for player:", player)
    end
end

-- Handles a player leaving
local function player_removed(player: Player): nil
    local uuid = player:GetAttribute("uuid")
    entity_manager.destroy_entity(uuid)
    print("Player", player, "left.")

    local player_data = data_manager.get_loaded_data(player.UserId)
    if player_data then
        data_manager.set_data(player.UserId, player_data)
        print("Data saved for player:", player)
    else
        print("No data to save for player:", player)
    end
end

players.PlayerAdded:Connect(player_added)
players.PlayerRemoving:Connect(player_removed)