        local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local AimlockEnabled = false
local FOVCircle = Drawing.new("Circle")
local Config = {
    TeamCheck = false,
    WallCheck = false,
    KnockCheck = true,
    ShowFOV = true,
    RainbowFOV = false,
    FillFOV = false,
    Sensitivity = 1,
    FOVSize = 100,
    TargetPart = "Head",
    FOVRainbowSpeed = 5,
    Prediction = 0.1,
    ForceFieldCheck = true -- Added ForceField Check
}
FOVCircle.Visible = Config.ShowFOV
FOVCircle.Transparency = 1
FOVCircle.Color = Color3.new(1, 1, 1)
FOVCircle.Thickness = 2
FOVCircle.Filled = Config.FillFOV
FOVCircle.Radius = Config.FOVSize
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

local Window = OrionLib:MakeWindow({
    Name = "Scamming Hub - UNIVERSAL [ BETA ]",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Scamming Hub - Universal"
})

local AimbotTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local AimlockToggle = AimbotTab:AddToggle({
    Name = "Aimbot",
    Default = false,
    Callback = function(Value)
        AimlockEnabled = Value
        if not Value then
            currentTarget = nil
        end
    end
})

AimbotTab:AddToggle({
    Name = "Team Check",
    Default = Config.TeamCheck,
    Callback = function(Value)
        Config.TeamCheck = Value
    end
})

AimbotTab:AddToggle({
    Name = "Wall Check",
    Default = true,
    Callback = function(Value)
        Config.WallCheck = Value
    end
})

AimbotTab:AddToggle({
    Name = "Knock Check",
    Default = true,
    Callback = function(Value)
        Config.KnockCheck = Value
    end
})

AimbotTab:AddToggle({
    Name = "Show FOV",
    Default = false,
    Callback = function(Value)
        Config.ShowFOV = Value
        FOVCircle.Visible = Value
    end
})

AimbotTab:AddToggle({
    Name = "Rainbow FOV",
    Default = Config.RainbowFOV,
    Callback = function(Value)
        Config.RainbowFOV = Value
    end
})

AimbotTab:AddToggle({
    Name = "Fill FOV",
    Default = Config.FillFOV,
    Callback = function(Value)
        Config.FillFOV = Value
        FOVCircle.Filled = Value
        FOVCircle.Transparency = Value and 0.5 or 1
    end
})

AimbotTab:AddToggle({
    Name = "ForceField Check", -- Added ForceField Check Toggle
    Default = true,
    Callback = function(Value)
        Config.ForceFieldCheck = Value
    end
})

AimbotTab:AddSlider({
    Name = "FOV Size",
    Min = 50,
    Max = 500,
    Default = Config.FOVSize,
    Increment = 10,
    Callback = function(Value)
        Config.FOVSize = Value
        FOVCircle.Radius = Value
    end
})

AimbotTab:AddSlider({
    Name = "Sensitivity",
    Min = 0.1,
    Max = 1,
    Default = Config.Sensitivity,
    Increment = 0.1,
    Callback = function(Value)
        Config.Sensitivity = Value
    end
})

AimbotTab:AddSlider({
    Name = "Rainbow Speed",
    Min = 1,
    Max = 10,
    Default = Config.FOVRainbowSpeed,
    Increment = 1,
    Callback = function(Value)
        Config.FOVRainbowSpeed = Value
    end
})

AimbotTab:AddSlider({
    Name = "Prediction",
    Min = 0,
    Max = 1,
    Default = 0.03,
    Increment = 0.01,
    Callback = function(Value)
        Config.Prediction = Value
    end
})

AimbotTab:AddDropdown({
    Name = "Target Part",
    Options = {"Head", "HumanoidRootPart", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
    Default = Config.TargetPart,
    Callback = function(Value)
        Config.TargetPart = Value
    end
})

local function IsVisible(targetPart)
    if not Config.WallCheck then return true end
    local rayOrigin = Camera.CFrame.Position
    local rayDirection = (targetPart.Position - rayOrigin).Unit * 1000
    local ray = Ray.new(rayOrigin, rayDirection)
    local ignoreList = {LocalPlayer.Character}
    local hit, hitPosition = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
    if hit then
        return hit:IsDescendantOf(targetPart.Parent)
    end
    return true
end

local currentTarget = nil
local mb2Down = false

local function FindClosestTarget()
    local closestTarget = nil
    local closestDistanceToCenter = math.huge
    local mousePos = UserInputService:GetMouseLocation()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local targetPart = character:FindFirstChild(Config.TargetPart)
            if humanoid and targetPart then
                -- Skip if player has a ForceField
                if Config.ForceFieldCheck and character:FindFirstChildOfClass("ForceField") then
                    continue
                end
                -- Skip if player is knocked or dead
                if Config.KnockCheck and (humanoid.Health <= 0 or humanoid:GetState() == Enum.HumanoidStateType.Dead) then
                    continue
                end
                local screenPos, visible = Camera:WorldToViewportPoint(targetPart.Position)
                if visible then
                    local screenPoint = Vector2.new(screenPos.X, screenPos.Y)
                    local distanceFromCenter = (mousePos - screenPoint).Magnitude
                    if distanceFromCenter <= Config.FOVSize then
                        -- Skip if player is on the same team
                        if Config.TeamCheck and player.Team == LocalPlayer.Team then
                            continue
                        end
                        -- Skip if target is not visible
                        if not IsVisible(targetPart) then
                            continue
                        end
                        -- Set closest target
                        if distanceFromCenter < closestDistanceToCenter then
                            closestDistanceToCenter = distanceFromCenter
                            closestTarget = targetPart
                        end
                    end
                end
            end
        end
    end
    return closestTarget
end

local function Aimlock()
    if currentTarget and mb2Down then
        local targetVelocity = currentTarget.Velocity
        local predictedPosition = currentTarget.Position + (targetVelocity * Config.Prediction)
        local newCFrame = CFrame.new(Camera.CFrame.Position, predictedPosition)
        Camera.CFrame = newCFrame
    end
end

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = UserInputService:GetMouseLocation()
    FOVCircle.Radius = Config.FOVSize
    FOVCircle.Filled = Config.FillFOV
    FOVCircle.Visible = Config.ShowFOV
    if Config.RainbowFOV then
        local hue = tick() % Config.FOVRainbowSpeed / Config.FOVRainbowSpeed
        FOVCircle.Color = Color3.fromHSV(hue, 1, 1)
    else
        FOVCircle.Color = Color3.new(1, 1, 1)
    end
    FOVCircle.Transparency = Config.FillFOV and 0.5 or 1
end)

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and AimlockEnabled then
        mb2Down = true
        currentTarget = FindClosestTarget()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        mb2Down = false
        currentTarget = nil
    end
end)

RunService.Heartbeat:Connect(function()
    if AimlockEnabled and mb2Down then
        if not currentTarget then
            currentTarget = FindClosestTarget()
        end
        Aimlock()
    else
        currentTarget = nil
    end
end)

AimbotTab:AddButton({
	Name = "TriggerBot",
	Callback = function()
			-- Settings
local HoldClick = true
local Hotkey = 't' -- Leave blank for always on
local HotkeyToggle = true -- True if you want it to toggle on and off with a click

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Toggle = (Hotkey ~= '')
local CurrentlyPressed = false

Mouse.KeyDown:Connect(function(key)
	if HotkeyToggle == true and key == Hotkey then
		Toggle = not Toggle
	elseif 
		key == Hotkey then
		Toggle = true
	end
end)

Mouse.KeyUp:Connect(function(key)
	if HotkeyToggle ~= true and key == Hotkey then
		Toggle = false
	end
end)

RunService.RenderStepped:Connect(function()
	if Toggle then
		if Mouse.Target then
			if Mouse.Target.Parent:FindFirstChild('Humanoid') then
				if HoldClick then
					if not CurrentlyPressed then
						CurrentlyPressed = true
						mouse1press()
					end
				else
					mouse1click()
				end
			else
				if HoldClick then
					CurrentlyPressed = false
					mouse1release()
				end
			end
		end
	end
end)


game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Triggerbot",
	Text = "Triggerbot Toggle : P", 
	
	Button1 = "ok",
	Duration = 30 
	})
	end    
})

local EspTab = Window:MakeTab({
    Name = "Esp",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local BoxSection = EspTab:AddSection({
    Name = "2D Box"
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Typing = false
local Squares = {}
local Healthbars = {}

_G.SendNotifications = true
_G.DefaultSettings = false
_G.TeamCheck = false
_G.SquaresVisible = false
_G.SquareColor = Color3.fromRGB(255, 255, 255) -- Default color: White
_G.SquareThickness = 1
_G.SquareTransparency = 0.7
_G.SquareFilled = false
_G.HealthbarVisible = false
_G.RainbowBox = false
_G.RainbowSpeed = 5

local function CreateSquare(v)
    local Square = Drawing.new("Square")
    Square.Thickness = _G.SquareThickness
    Square.Transparency = _G.SquareTransparency
    Square.Color = _G.SquareColor
    Square.Filled = _G.SquareFilled
    Square.Visible = false

    local Healthbar = Drawing.new("Line")
    Healthbar.Thickness = 2
    Healthbar.Color = Color3.fromRGB(0, 255, 0) -- Healthbar color: Green
    Healthbar.Visible = false

    Squares[v] = Square
    Healthbars[v] = Healthbar

    RunService.RenderStepped:Connect(function()
        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local Victim_HumanoidRootPart, OnScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            local Victim_Head = Camera:WorldToViewportPoint(v.Character.Head.Position + Vector3.new(0, 0.5, 0))
            local Victim_Legs = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0))

            if OnScreen then
                Square.Size = Vector2.new(2000 / Victim_HumanoidRootPart.Z, Victim_Head.Y - Victim_Legs.Y)
                Square.Position = Vector2.new(Victim_HumanoidRootPart.X - Square.Size.X / 2, Victim_HumanoidRootPart.Y - Square.Size.Y / 2)
                Square.Visible = _G.SquaresVisible

                Square.Thickness = _G.SquareThickness
                Square.Transparency = _G.SquareTransparency
                Square.Color = _G.SquareColor
                Square.Filled = _G.SquareFilled

                -- Healthbar (left side of the box)
                Healthbar.From = Vector2.new(Square.Position.X - 10, Square.Position.Y + Square.Size.Y)
                Healthbar.To = Vector2.new(Square.Position.X - 10, Square.Position.Y)
                Healthbar.Visible = _G.HealthbarVisible

                if _G.TeamCheck then
                    Square.Visible = v.Team ~= LocalPlayer.Team
                    Healthbar.Visible = v.Team ~= LocalPlayer.Team and _G.HealthbarVisible
                end
            else
                Square.Visible = false
                Healthbar.Visible = false
            end
        else
            Square.Visible = false
            Healthbar.Visible = false
        end
    end)
end

local function RemoveSquare(v)
    if Squares[v] then
        Squares[v]:Remove()
        Healthbars[v]:Remove()
        Squares[v] = nil
        Healthbars[v] = nil
    end
end

Players.PlayerAdded:Connect(function(v)
    repeat wait() until v.Character
    CreateSquare(v)
end)

Players.PlayerRemoving:Connect(function(v)
    RemoveSquare(v)
end)

for _, v in next, Players:GetPlayers() do
    if v ~= LocalPlayer then
        CreateSquare(v)
    end
end

EspTab:AddToggle({
    Name = "2D Box",
    Default = _G.SquaresVisible,
    Callback = function(Value)
        _G.SquaresVisible = Value
    end    
})

EspTab:AddToggle({
    Name = "Healthbar",
    Default = _G.HealthbarVisible,
    Callback = function(Value)
        _G.HealthbarVisible = Value
    end    
})

EspTab:AddToggle({
    Name = "Team Check", 
    Default = _G.TeamCheck,
    Callback = function(Value)
        _G.TeamCheck = Value
    end    
})

EspTab:AddToggle({
    Name = "Rainbow 2D Box", 
    Default = _G.RainbowBox,
    Callback = function(Value)
        _G.RainbowBox = Value
        if not Value then
            _G.SquareColor = Color3.fromRGB(255, 255, 255) -- Reset to white when disabled
        end
    end    
})

EspTab:AddSlider({
    Name = "Rainbow Speed",
    Min = 0,
    Max = 1,
    Default = _G.RainbowSpeed,
    Color = Color3.fromRGB(255,255,255),
    Increment = 0.1,
    ValueName = "Speed",
    Callback = function(Value)
        _G.RainbowSpeed = Value
    end    
})

EspTab:AddSlider({
    Name = "Box Thickness",
    Min = 1,
    Max = 10,
    Default = _G.SquareThickness,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Thickness",
    Callback = function(Value)
        _G.SquareThickness = Value
    end    
})

EspTab:AddSlider({
    Name = "Box Transparency",
    Min = 0,
    Max = 1,
    Default = _G.SquareTransparency,
    Color = Color3.fromRGB(255,255,255),
    Increment = 0.1,
    ValueName = "Transparency",
    Callback = function(Value)
        _G.SquareTransparency = Value
    end    
})

EspTab:AddColorpicker({
    Name = "Box Color",
    Default = _G.SquareColor,
    Callback = function(Value)
        _G.SquareColor = Value
    end	  
})

local localuser = Window:MakeTab({
	Name = "Local Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

localuser:AddLabel("Wait until the Local Player update drops")

OrionLib:Init()

while wait() do
    if _G.RainbowBox then
        _G.SquareColor = Color3.fromHSV(tick() * _G.RainbowSpeed % 1, 1, 1)
    end
end
