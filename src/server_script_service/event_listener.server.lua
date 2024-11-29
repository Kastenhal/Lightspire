-- Services
local server_script_service = game:GetService("ServerScriptService")
local replicated_storage = game:GetService("ReplicatedStorage")

-- Modules
local entity_manager = require(server_script_service.managers.entity_manager)

-- Event Listener
local remotes = replicated_storage.remotes:GetChildren()

local function handle_event(player, input_state, event_name)
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

    local action_prefix = input_state == Enum.UserInputState.Begin and "start_" or "stop_"
    entity.state_machine:perform_action(action_prefix .. event_name)
end

local function initialize_connections()
    for _, event in ipairs(remotes) do
        event.OnServerEvent:Connect(function(player, input_state)
            handle_event(player, input_state, event.Name)
        end)
    end
end

initialize_connections()
