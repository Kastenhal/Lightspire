-- Services
local server_script_service = game:GetService("ServerScriptService")

-- Modules
local state_machine = require(server_script_service.state_machine)

-- Entity Factory
local entity_factory = {}

-- Create a new entity
function entity_factory.create_entity(name, data)
    local entity = {}
    entity.name = name or "Unnamed Entity"
    entity.data = data or {}
    entity.properties = {}
    entity.state_machine = state_machine.new()

    -- Add states
    entity.state_machine:add_state("idle", {
        on_enter = function()
            print(entity.name .. " entered idle state.")
        end,
        on_exit = function()
            print(entity.name .. " exited idle state.")
        end,
        actions = {
            start_sprint = function()
                entity.state_machine:transition_to("sprinting")
            end,
        },
    })

    entity.state_machine:add_state("sprinting", {
        on_enter = function()
            print(entity.name .. " started sprinting.")
        end,
        on_exit = function()
            print(entity.name .. " stopped sprinting.")
        end,
        actions = {
            stop_sprint = function()
                entity.state_machine:transition_to("idle")
            end,
        },
    })

    -- Set the initial state
    entity.state_machine:transition_to("idle")

    return entity
end

return entity_factory
