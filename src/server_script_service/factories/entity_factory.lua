-- Services
local server_script_service = game:GetService("ServerScriptService")

-- Modules
local state_machine = require(server_script_service.state_machine)

-- Entity Factory
local entity_factory = {}

function entity_factory.create_entity(name, data)
    local entity = {}
    entity.name = name or "entity"
    entity.data = data or {}
    entity.properties = {}
    entity.state_machine = state_machine.new()

    -- Example: Add simple states
    entity.state_machine:add_state("idle", {
        start_sprint = function()
            entity.state_machine:set_state("sprinting")
            entity.state_machine:perform_action("sprint")
        end,
        start_move_forward = function()
            entity:set_attribute("moving_forward", true)
            entity.state_machine:set_state("moving")
        end
    })

    entity.state_machine:add_state("moving", {
        stop_move_forward = function()
            if entity:get_attribute("moving_left") or entity:get_attribute("moving_backward") or entity:get_attribute("moving_right") then
                print("Still moving.")
                return
            end
            entity.state_machine:set_state("idle")
        end,
        stop_move_left = function()
            if entity:get_attribute("moving_backward") or entity:get_attribute("moving_right") or entity:get_attribute("moving_forward") then
                print("Still moving.")
                return
            end
            entity.state_machine:set_state("idle")
        end,
        stop_move_backward = function()
            if entity:get_attribute("moving_right") or entity:get_attribute("moving_forward") or entity:get_attribute("moving_left") then
                print("Still moving.")
                return
            end
            entity.state_machine:set_state("idle")
        end,
        stop_move_right = function()
            if entity:get_attribute("moving_forward") or entity:get_attribute("moving_left") or entity:get_attribute("moving_backward") then
                print("Still moving.")
                return
            end
            entity.state_machine:set_state("idle")
        end
    })

    entity.state_machine:add_state("sprinting", {
        sprint = function()
            print("Player is sprinting.")
        end,
        stop_sprint = function()
            print("Player is no longer sprinting")
            entity.state_machine:set_state("idle")
        end
    })

    -- Set the initial state
    entity.state_machine:set_state("idle")

    -- Accessor and setter methods
    function entity:get_attribute(name)
        assert(entity.properties[name], "Property " .. name .. " does not exist.")
        return entity.properties[name]
    end

    function entity:set_attribute(name, data)
        entity.properties[name] = data
    end

    -- Incrementor method
    function entity:update_attribute(name, data)
        entity.properties[name] = entity.properties[name] + data
    end

    -- Return the entity object
    return entity
end

return entity_factory
