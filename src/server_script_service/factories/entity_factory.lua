-- Services
local server_script_service = game:GetService("ServerScriptService")

-- Modules
local state_machine = require(server_script_service.state_machine)

-- Entity Factory
local entity_factory = {}

-- Create a new entity
function entity_factory.create_entity(name, data)
    local entity = {}
    entity.name = name or "entity"
    entity.data = data or {}
    entity.properties = {}
    entity.state_machine = state_machine.new()

    -- Helper: Add idle state
    local function add_idle_state()
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
                start_move_forward = function()
                    entity:set_attribute("moving_forward", true)
                    entity.state_machine:transition_to("moving")
                end,
            }
        })
    end

    -- Helper: Add moving state
    local function add_moving_state()
        entity.state_machine:add_state("moving", {
            on_enter = function()
                print(entity.name .. " started moving.")
            end,
            on_exit = function()
                entity:set_attribute("moving_forward", false)
                print(entity.name .. " stopped moving.")
            end,
            actions = {
                stop_move_forward = function()
                    if entity:is_moving() then
                        print("Still moving.")
                        return
                    end
                    entity.state_machine:transition_to("idle")
                end,
            }
        })
    end

    -- Helper: Add sprinting state
    local function add_sprinting_state()
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
            }
        })
    end

    -- Add all states
    add_idle_state()
    add_moving_state()
    add_sprinting_state()

    -- Set the initial state
    entity.state_machine:transition_to("idle")

    -- Accessor for attributes
    function entity:get_attribute(attribute_name)
        assert(self.properties[attribute_name], "Property '" .. attribute_name .. "' does not exist.")
        return self.properties[attribute_name]
    end

    -- Setter for attributes
    function entity:set_attribute(attribute_name, value)
        self.properties[attribute_name] = value
    end

    -- Update an attribute
    function entity:update_attribute(attribute_name, increment)
        assert(type(increment) == "number", "Increment must be a number.")
        if not self.properties[attribute_name] then
            self.properties[attribute_name] = 0
        end
        self.properties[attribute_name] = self.properties[attribute_name] + increment
    end

    -- Utility: Check if entity is moving
    function entity:is_moving()
        return self:get_attribute("moving_forward") or
               self:get_attribute("moving_backward") or
               self:get_attribute("moving_left") or
               self:get_attribute("moving_right")
    end

    -- Return the entity object
    return entity
end

return entity_factory
