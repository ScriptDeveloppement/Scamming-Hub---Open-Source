local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 700, 0, 350) -- Increased width
frame.Position = UDim2.new(0.5, -350, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 2
frame.Parent = screenGui

local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
titleBar.Text = "Scamming Internal"
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 18
titleBar.Parent = frame

local dragging, dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -20, 0.7, -40)
inputBox.Position = UDim2.new(0, 10, 0, 40)
inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Text = ""
inputBox.ClearTextOnFocus = false
inputBox.MultiLine = true
inputBox.Font = Enum.Font.Code
inputBox.TextSize = 14
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.TextYAlignment = Enum.TextYAlignment.Top
inputBox.Parent = frame

local function highlightSyntax()
    local code = inputBox.Text
    -- Simple syntax highlighting example (this is basic and does not fully highlight Lua code)
    code = code:gsub("function", "\226\157\164function\226\157\165")
    inputBox.Text = code
end

inputBox:GetPropertyChangedSignal("Text"):Connect(highlightSyntax)

local executeButton = Instance.new("TextButton")
executeButton.Size = UDim2.new(0, 150, 0, 40)
executeButton.Position = UDim2.new(0, 10, 1, -50)
executeButton.Text = "Execute"
executeButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
executeButton.Font = Enum.Font.Gotham
titleBar.TextSize = 20
executeButton.Parent = frame

local clearButton = Instance.new("TextButton")
clearButton.Size = UDim2.new(0, 150, 0, 40)
clearButton.Position = UDim2.new(0, 170, 1, -50)
clearButton.Text = "Clear"
clearButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
clearButton.Font = Enum.Font.Gotham
clearButton.TextSize = 16
clearButton.Parent = frame

executeButton.MouseButton1Click:Connect(function()
    local code = inputBox.Text
    local success, result = pcall(loadstring(code))
    if not success then
        print("Execution Error: " .. tostring(result))
    end
end)

clearButton.MouseButton1Click:Connect(function()
    inputBox.Text = ""
end)
