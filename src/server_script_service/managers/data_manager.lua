-- Serivces
local data_store_service = game:GetService("DataStoreService")

-- Data Stores
local player_data_store = data_store_service:GetDataStore("player_data")

-- Data Manager
local data_manager = {}
data_manager.__index = data_manager

function data_manager.save_data(player_id, data)
    local player_key = "player_" .. player_id

    local success, error_message = pcall(function()
        player_data_store:SetAsync(player_key, data)
    end)
    
    if not success then
        warn("Failed to save data for " .. data.Name .. ": " .. error_message)
    end
end

function data_manager.load_data(player_id)
    local player_key = "player_" .. player_id

    local success, data = pcall(function()
        return player_data_store:GetAsync(player_key)
    end)

    if success and data then
        return player_data_store:GetAsync(player_key)
    end
end

return data_manager