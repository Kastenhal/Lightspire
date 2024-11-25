-- Services
local server_script_service = game:GetService("ServerScriptService")

-- Modules
local state_machine = require(server_script_service.state_machine)

-- Entity Factory
local entity_factory = {}

function entity_factory.create_entity(name, properties)
    local entity = {}
    entity.name = name or "entity"
    entity.properties = properties or {}
    entity.state_machine = state_machine.new()

    -- Example: Add simple states
    entity.state_machine:add_state("idle", {
        move = function()
            print(entity.name .. " starts moving.")
            entity.state_machine:set_state("moving")
        end,
    })

    entity.state_machine:add_state("moving", {
        stop = function()
            print(entity.name .. " stops moving.")
            entity.state_machine:set_state("idle")
        end,
    })

    -- Set the initial state
    entity.state_machine:set_state("idle")
    
    -- Return the entity object
    return entity
end

return entity_factory
