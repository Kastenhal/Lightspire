-- Services
local user_input_service = game:GetService("UserInputService")
local replicated_storage = game:GetService("ReplicatedStorage")

-- Folders
local remotes = replicated_storage:WaitForChild("remotes")

-- Input to action mapping
local input_actions = {
    [Enum.KeyCode.LeftShift] = "sprint",
}

-- Function to handle input
local function handle_input(input_object)
    if input_object.UserInputType ~= Enum.UserInputType.Keyboard then return end

    local action_name = input_actions[input_object.KeyCode]
    if not action_name then
        warn("No action mapped for key: " .. tostring(input_object.KeyCode))
        return
    end

    local remote = remotes:FindFirstChild(action_name)
    if not remote then
        warn("No remote found for action: " .. action_name)
        return
    end

    -- Fire the corresponding remote event
    remote:FireServer(input_object.UserInputState)
end

-- Connect to InputBegan and InputEnded
user_input_service.InputBegan:Connect(handle_input)
user_input_service.InputEnded:Connect(handle_input)
