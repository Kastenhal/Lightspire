-- State Machine
local state_machine = {}
state_machine.__index = state_machine

-- Constructor for state_machine
function state_machine.new()
    local self = setmetatable({}, state_machine)
    self.states = {} -- Holds all states
    self.current_state = nil -- Tracks the current state
    return self
end

-- Add a new state with its actions and events
function state_machine:add_state(state_name, actions, events)
    assert(type(state_name) == "string", "State name must be a string")
    assert(type(actions) == "table", "Actions must be a table of functions")
    self.states[state_name] = {
        actions = actions,
        events = events or {}, -- Events are optional
    }
end

-- Set the current state
function state_machine:set_state(state_name)
    assert(self.states[state_name], "State does not exist: " .. tostring(state_name))
    self.current_state = state_name
end

-- Get the current state
function state_machine:get_state()
    return self.current_state
end

-- Perform an action in the current state
function state_machine:perform_action(action_name, ...)
    if not self.current_state then
        error("No current state is set!")
    end

    local state = self.states[self.current_state]
    local action = state.actions[action_name]

    if not action then
        error("Action '" .. tostring(action_name) .. "' not available in state '" .. self.current_state .. "'")
    end

    -- Call the action with any provided arguments
    return action(...)
end

-- Check events in the current state and transition if any event triggers
function state_machine:check_events(...)
    if not self.current_state then
        error("No current state is set!")
    end

    local state = self.states[self.current_state]
    for event_name, event_data in pairs(state.events) do
        local condition = event_data.condition
        local target_state = event_data.target_state

        -- If the event condition is met, transition to the target state
        if condition(...) then
            print("Event triggered:", event_name, "Transitioning to state:", target_state)
            self:set_state(target_state)
            return
        end
    end
end

return state_machine
