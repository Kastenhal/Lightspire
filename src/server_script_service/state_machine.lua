local state_machine = {}
state_machine.__index = state_machine

function state_machine.new()
    return setmetatable({states = {}, current_state = nil}, state_machine)
end

function state_machine:add_state(name, config)
    self.states[name] = config
end

function state_machine:transition_to(name, ...)
    local state = self.states[name]
    if not state then error("State '" .. name .. "' not found") end
    if self.current_state and self.states[self.current_state].on_exit then
        self.states[self.current_state].on_exit(...)
    end
    self.current_state = name
    if state.on_enter then state.on_enter(...) end
end

function state_machine:perform_action(action, ...)
    local state = self.states[self.current_state]
    if not state or not state.actions[action] then error("Action '" .. action .. "' not found in state '" .. self.current_state .. "'") end
    return state.actions[action](...)
end

return state_machine
