-- Services
local server_script_service = game:GetService("ServerScriptService")
local replicated_storage = game:GetService("ReplicatedStorage")

-- Modules
local entity_manager = require(server_script_service.managers.entity_manager)

-- Handle remote events
local function handle_event(player, input_state, event_name)
    local entity = entity_manager.get_entity(player:GetAttribute("entity_id"))
    if entity then
        local action_prefix = input_state == Enum.UserInputState.Begin and "start_" or "stop_"
        entity.state_machine:perform_action(action_prefix .. event_name)
    else
        warn("Invalid entity for player:", player.Name)
    end
end

-- Initialize connections
for _, event in ipairs(replicated_storage.remotes:GetChildren()) do
    event.OnServerEvent:Connect(function(player, input_state)
        handle_event(player, input_state, event.Name)
    end)
end
