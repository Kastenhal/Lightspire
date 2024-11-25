-- Services
local ServerScriptService = game:GetService("ServerScriptService")

-- Modules
local StateMachine = require(ServerScriptService.state_machine)

-- Entity Factory
local EntityFactory = {}

function EntityFactory.create_entity(name)
    local entity = {}
    entity.name = name or "Entity"
    entity.state_machine = StateMachine.new()

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

return EntityFactory
