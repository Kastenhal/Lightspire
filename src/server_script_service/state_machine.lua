local state_machine = {}
state_machine.__index = state_machine

-- Constructor
function state_machine.new()
    local self = setmetatable({}, state_machine)
    self.states = {}
    self.current_state = nil
    return self
end

-- Add a new state
function state_machine:add_state(state_name, config)
    self.states[state_name] = {
        actions = config.actions or {},
        on_enter = config.on_enter or function() end,
        on_exit = config.on_exit or function() end,
    }
end

-- Transition to a new state
function state_machine:transition_to(state_name, ...)
    local state = self.states[state_name]
    if not state then
        error("State '" .. state_name .. "' does not exist")
    end

    if self.current_state then
        local exit_func = self.states[self.current_state].on_exit
        exit_func(self.current_state, ...)
    end

    self.current_state = state_name

    local enter_func = state.on_enter
    enter_func(state_name, ...)
end

-- Perform an action in the current state
function state_machine:perform_action(action_name, ...)
    if not self.current_state then
        error("No current state is set!")
    end

    local state = self.states[self.current_state]
    local action = state.actions[action_name]

    if not action then
        error("Action '" .. action_name .. "' not available in state '" .. self.current_state .. "'")
    end

    return action(...)
end

return state_machine
