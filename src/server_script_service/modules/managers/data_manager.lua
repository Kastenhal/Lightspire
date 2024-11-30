-- services
local server_script_service = game:GetService("ServerScriptService")
local data_store_service = game:GetService("DataStoreService")

-- classes
local data_template = require(server_script_service.modules.data_template)

-- data store
local data_store = data_store_service:GetDataStore("lightspire_data_store")

-- data_manager.lua
local data_manager = {}
data_manager.__index = data_manager

data_manager.loaded_data = {}

-- Gets data for a player
function data_manager.get_data(player_id: number): table
    local key = "player_" .. player_id

    local success, data = pcall(function()
        return data_store:GetAsync(key)
    end)

    if not success or data == nil then
        warn("Data could not be found or is nil.")
    end

    return data
end

-- Gets loaded data for a player
function data_manager.get_loaded_data(player_id: number) : table
    local key = "player_" .. player_id
    return data_manager.loaded_data[key] or nil
end

-- Gets all loaded data
function data_manager.get_all_data(): table
    local all_data = {}

    for key, value in pairs(data_manager.loaded_data) do
        all_data[key] = value
    end

    return all_data
end

-- Sets data for a player
function data_manager.set_data(player_id: number, value: table): nil
    local key = "player_" .. player_id

    local success, errorMessage = pcall(function()
        data_store:SetAsync(key, value)
    end)

    if not success then
        warn("Failed to set data for player:", errorMessage)
    end
end

-- Updates specific data for a player
function data_manager.update_data(player_id: number, key: string, value: any): nil
    local data_key = "player_" .. player_id
    local player_data = data_manager.loaded_data[data_key]
    if not player_data then
        warn("Data for player", player_id, "is not loaded.")
        return
    end

    player_data[key] = value
    print("Updated data for player", player_id, ":", key, "=", value)
end

-- Saves all loaded data
function data_manager.save_all_data(): nil
    for key, value in pairs(data_manager.loaded_data) do
        local success, errorMessage = pcall(function()
            data_store:SetAsync(key, value)
        end)
        if not success then
            warn("Failed to save data for key:", key, errorMessage)
        end
    end
    print("All data saved.")
end

-- Loads data for a player
function data_manager.load_data(player_id: number): table
    local key = "player_" .. player_id

    local success, data = pcall(function()
        return data_store:GetAsync(key)
    end)

    if success and data ~= nil then
        data_manager.loaded_data[key] = data
    else
        if not success then
            warn("Failed to load data for:", key)
        elseif data == nil then
            warn("Data for player is nil, initializing empty data.")
            data_manager.loaded_data[key] = data_template.new()
        end
    end

    return data_manager.loaded_data[key]
end

-- Deletes all loaded data
function data_manager.delete_all_data(): nil
    for key, _ in pairs(data_manager.loaded_data) do
        local success, errorMessage = pcall(function()
            data_store:RemoveAsync(key)
        end)

        if not success then
            warn("Failed to delete data for key:", key, errorMessage)
        end
    end

    data_manager.loaded_data = {}
end

return data_manager