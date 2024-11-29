-- Services
local user_input_service = game:GetService("UserInputService")
local remotes = game:GetService("ReplicatedStorage"):WaitForChild("remotes")

-- Input Actions Mapping
local input_actions = { [Enum.KeyCode.LeftShift] = "sprint" }

-- Fire Remote
local function fire_remote(action_name, input_state)
    local remote = remotes:FindFirstChild(action_name)
    if not remote then
        warn("No remote found for action: " .. tostring(action_name))
        return
    end
    remote:FireServer(input_state)
end

-- Handle Input
local function handle_input(input_object)
    local action_name = input_actions[input_object.KeyCode]
    if action_name then
        fire_remote(action_name, input_object.UserInputState)
    end
end

user_input_service.InputBegan:Connect(handle_input)
user_input_service.InputEnded:Connect(handle_input)
