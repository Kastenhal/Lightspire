-- Services
local server_script_service = game:GetService("ServerScriptService")
local replicated_storage = game:GetService("ReplicatedStorage")

-- Modules
local entity_manager = require(server_script_service.managers.entity_manager)

-- Event Listener
local remotes = replicated_storage.remotes:GetChildren()

local function connection(player, input_state, event_name)
    local entity = entity_manager.get_entity(player:GetAttribute("entity_id"))

    if input_state == Enum.UserInputState.Begin then
        entity.state_machine:perform_action("start_" .. event_name)
    end

    if input_state == Enum.UserInputState.End then
       entity.state_machine:perform_action("stop_" .. event_name) 
    end
end

local function initialize_connections()
    for _, event in ipairs(remotes) do
        event.OnServerEvent:Connect(function(player, input_state)
            connection(player, input_state, event.Name)
        end)
    end
end

initialize_connections()