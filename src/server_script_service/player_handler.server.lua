-- Manage player lifecycle
local players = game:GetService("Players")
local server_script_service = game:GetService("ServerScriptService")
local data_manager = require(server_script_service.managers.data_manager)
local entity_factory = require(server_script_service.factories.entity_factory)
local entity_manager = require(server_script_service.managers.entity_manager)

local function manage_player(player, is_joining)
    if is_joining then
        local entity = entity_factory.create_entity(player.Name, data_manager.load_data(player.UserId))
        player:SetAttribute("entity_id", entity_manager.add_entity(entity))
    else
        local entity_id = player:GetAttribute("entity_id")
        local entity = entity_manager.get_entity(entity_id)
        if entity then
            data_manager.save_data(entity.player_id, entity.properties)
            entity_manager.remove_entity(entity_id)
        end
    end
end

players.PlayerAdded:Connect(function(player) manage_player(player, true) end)
players.PlayerRemoving:Connect(function(player) manage_player(player, false) end)
