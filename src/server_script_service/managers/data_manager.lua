-- Data Manager
local data_manager = {}
local data_store_service = game:GetService("DataStoreService")
local player_data_store = data_store_service:GetDataStore("player_data")

function data_manager.save_data(player_id, data)
    if not data then
        warn("Cannot save data: Data is nil for player_id: " .. tostring(player_id))
        return
    end

    local player_key = "player_" .. tostring(player_id)
    local player_name = data.Name or "Unknown" -- Fallback if data.Name is nil

    local success, error_message = pcall(function()
        player_data_store:SetAsync(player_key, data)
    end)

    if not success then
        warn("Failed to save data for " .. player_name .. ": " .. tostring(error_message))
    end
end

function data_manager.load_data(player_id)
    local player_key = "player_" .. tostring(player_id)

    local success, data = pcall(function()
        return player_data_store:GetAsync(player_key)
    end)

    if success and data then
        return data
    else
        warn("Failed to load data for player_id: " .. tostring(player_id))
        return nil
    end
end

return data_manager
