local g = getinfo or debug.getinfo
local d = false
local h = {}

local x, y

setthreadidentity(2)

for i, v in getgc(true) do
    if typeof(v) == "table" then
        local a = rawget(v, "Detected")
        local b = rawget(v, "Kill")
    
        if typeof(a) == "function" and not x then
            x = a
            
            local o; o = hookfunction(x, function(c, f, n)
                if c ~= "_" then
                    if d then
                        warn(`Adonis AntiCheat flagged\nMethod: {c}\nInfo: {f}`)
                    end
                end
                
                return true
            end)

            table.insert(h, x)
        end

        if rawget(v, "Variables") and rawget(v, "Process") and typeof(b) == "function" and not y then
            y = b
            local o; o = hookfunction(y, function(f)
                if d then
                    warn(`Adonis AntiCheat tried to kill (fallback): {f}`)
                end
            end)

            table.insert(h, y)
        end
    end
end

local o; o = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local a, f = ...

    if x and a == x then
        if d then
            warn(`zins | adonis bypassed`)
        end

        return coroutine.yield(coroutine.running())
    end
    
    return o(...)
end))


setthreadidentity(7)

local function PepperAura()
    if not PepperSpray.Enabled or not LocalPlayer or not LocalPlayer.Character then return end

    local Tool = LocalPlayer.Character:FindFirstChild("Pepper-spray")
    if not Tool then return end

    if PepperSpray.InfiniteSpray then
        Tool.Ammo.Value = 100
        Tool.RemoteEvent:FireServer("Update", 100)
    end

    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character then
            local Target = Player.Character:FindFirstChild("HumanoidRootPart")
            if Target then
                local Distance = (LocalPlayer.Character.HumanoidRootPart.Position - Target.Position).Magnitude
                if Distance <= PepperSpray.Range then
                    Tool.RemoteEvent:FireServer("Spray", true)
                    Tool.RemoteEvent:FireServer("Hit", Player.Character)
                end
            end
        end
    end
end


local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Create Orion Window
local Window = OrionLib:MakeWindow({
    Name = "[ PRE ALPHA ] Scamming Hub - Criminality",
    IntroText = "Scamming Hub Loaded!",
    IntroIcon = "rbxassetid://4483345998",
    Icon = "rbxassetid://4483345998",
    SaveConfig = false
})

local GunModsTab = Window:MakeTab({
    Name = "Mods",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local PepperSpray = {
    Enabled = false,
    Range = 10,
    InfiniteSpray = false
}

local Settings = {
    NoRecoil = false,
    InstantEquip = false,
    Spread = false,
    SpreadAmount = 0,
    AutoMode = false,
    FullBright = false,
    NoFailLockpick = false,
    NoClip = false,
    UIKey = Enum.KeyCode.Insert,
    NoBarbwire = false,
    NoDoors = false,
    NoRagdoll = false,
    NoClipEnabled = false,
    NoFlashbang = false,
NoSmoke = false,
NoFailLockpick = false,
FullBright = false,
Enabled = false,
InfiniteSpray = false,
Range = 10,
Viewmodel = {
    Enabled = true,
    ArmsColor = Color3.fromRGB(255, 255, 255),
    ArmsMaterial = "ForceField",
    ToolColor = Color3.fromRGB(255, 255, 255),
    ToolMaterial = "Plastic"
}}

GunModsTab:AddToggle({
    Name = "No Recoil",
    Default = false,
    Flag = "NoRecoil",
    Callback = function(Value)
        Settings.NoRecoil = Value
        local success, err = pcall(function()
            for _, v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Recoil") then
                    v.Recoil = Value and 0 or v.Recoil
                end
            end
        end)
        if not success then
            warn("Error in No Recoil: " .. err)
        end
    end
})


GunModsTab:AddToggle({
    Name = "Instant Equip",
    Default = false,
    Flag = "InstantEquip",
    Callback = function(Value)
        Settings.InstantEquip = Value
        local success, err = pcall(function()
            for _, v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "EquipTime") then
                    v.EquipTime = Value and 0 or v.EquipTime
                end
            end
        end)
        if not success then warn("Error in Instant Equip: " .. err) end
    end
})

GunModsTab:AddToggle({
    Name = "No Spread",
    Default = false,
    Flag = "Spread",
    Callback = function(Value)
        Settings.Spread = Value
        local success, err = pcall(function()
            if not isfunction(getgc) then
                warn("getgc is not available.")
                return
            end

            for _, v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Spread") then
                    v.Spread = Value and Settings.SpreadAmount or v.Spread
                end
            end
        end)
        if not success then
            warn("Error in Custom Spread: " .. err)
        end
    end
})

GunModsTab:AddToggle({
    Name = "Auto Mode",
    Default = false,
    Flag = "AutoMode",
    Callback = function(Value)
        Settings.AutoMode = Value
        local success, err = pcall(function()
            for _, v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "FireModeSettings") then
                    v.FireModeSettings = Value and { FireMode = "Auto", BurstAmount = 6, BurstRate = 25, CanSwitch = true, SwitchTo = "Auto" } or v.FireModeSettings
                end
            end
        end)
        if not success then warn("Error in Auto Mode: " .. err) end
    end
})

local PepperSpraySection = GunModsTab:AddSection({
	Name = "Pepper Spray"
})

local function HandlePepperSprayAura()
    game:GetService("RunService").RenderStepped:Connect(function()
        wait(1)
        if PepperSpray.Enabled and game.Players.LocalPlayer.Character:FindFirstChild("Pepper-spray") then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                    if distance < PepperSpray.Range then
                        game.Players.LocalPlayer.Character["Pepper-spray"].RemoteEvent:FireServer("Spray", true)
                        game.Players.LocalPlayer.Character["Pepper-spray"].RemoteEvent:FireServer("Hit", v.Character)
                    else
                        game.Players.LocalPlayer.Character["Pepper-spray"].RemoteEvent:FireServer("Spray", false)
                    end
                end
            end
        end
    end)
end


HandlePepperSprayAura()

game:GetService("RunService").RenderStepped:Connect(function()
    wait(1)
    if PepperSpray.InfiniteSpray and game.Players.LocalPlayer.Character:FindFirstChild("Pepper-spray") then
        game.Players.LocalPlayer.Character["Pepper-spray"].Ammo.Value = 99
        game.Players.LocalPlayer.Character["Pepper-spray"].RemoteEvent:FireServer("Update", 99)
    end
end)



GunModsTab:AddToggle({
	Name = "Pepper Spray Aura",
	Default = false,
	Callback = function(Value)
        PepperSpray.Enabled = Value
	end    
})

GunModsTab:AddToggle({
	Name = "Infinite Pepper Spray",
	Default = false,
	Callback = function(Value)
        PepperSpray.InfiniteSpray = Value
	end    
})

GunModsTab:AddSlider({
	Name = "Pepper Spray Aura Range",
	Min = 1,
	Max = 20,
	Default = 10,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Range",
	Callback = function(Value)
		PepperSpray.Range = Value
	end    
})



-- viewmodel
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function UpdateViewmodel()
    if Workspace.Camera:FindFirstChild("ViewModel") then
        local vm = Workspace.Camera.ViewModel
        if Settings.Viewmodel.Enabled then
            for _, arm in pairs({"Left Arm", "Right Arm"}) do
                if vm[arm] then
                    vm[arm].Color = Settings.Viewmodel.ArmsColor
                    vm[arm].Material = Enum.Material[Settings.Viewmodel.ArmsMaterial]
                end
            end
            
            local vmTool = vm:FindFirstChildWhichIsA("Tool")
            if vmTool then
                for _, part in pairs(vmTool:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("MeshPart") then
                        part.Color = Settings.Viewmodel.ToolColor
                        part.Material = Enum.Material[Settings.Viewmodel.ToolMaterial]
                    end
                end
            end
        end
    end

    if LocalPlayer.Character and Settings.Viewmodel.Enabled then
        local tool = LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
        if tool then
            for _, part in pairs(tool:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("MeshPart") then
                    part.Color = Settings.Viewmodel.ToolColor
                    part.Material = Enum.Material[Settings.Viewmodel.ToolMaterial]
                end
            end
        end
    end
end

local VisualTab = Window:MakeTab({
    Name = "Visual",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local ViewModelSection = VisualTab:AddSection({
	Name = "View Model Section"
})

VisualTab:AddToggle({
    Name = "Enable Viewmodel Changer",
    Default = false,
    Callback = function(Value)
        Settings.Viewmodel.Enabled = Value
    end
})

VisualTab:AddColorpicker({
    Name = "Arms Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        Settings.Viewmodel.ArmsColor = Value
    end
})

VisualTab:AddDropdown({
    Name = "Arms Material",
    Default = "ForceField",
    Options = {"ForceField", "Plastic", "Wood", "Slate", "Concrete"},
    Callback = function(Value)
        Settings.Viewmodel.ArmsMaterial = Value
    end
})

VisualTab:AddColorpicker({
    Name = "Tool Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        Settings.Viewmodel.ToolColor = Value
    end
})

VisualTab:AddDropdown({
    Name = "Tool Material",
    Default = "ForceField",
    Options = {"ForceField", "Plastic", "Wood", "Slate", "Concrete"},
    Callback = function(Value)
        Settings.Viewmodel.ToolMaterial = Value
    end
})

-- Main loop
RunService.Heartbeat:Connect(UpdateViewmodel)

local VisualsSection = VisualTab:AddSection({
	Name = "Visuals"
})

PlayerTab:AddToggle({
    Name = "Anti Barbwire",
    Default = false,
    Callback = function(Value)
        Settings.NoBarbwire = Value
    end
})

PlayerTab:AddToggle({
    Name = "Anti Break Limbs",
    Default = false,
    Callback = function(Value)
        Settings.NoRagdoll = Value
    end
})

PlayerTab:AddToggle({
    Name = "Anti Fall Damage",
    Default = false,
    Callback = function(Value)
        Settings.NoFallDamage = Value
    end
})

PlayerTab:AddButton({
    Name = "Delete All Doors",
    Callback = function()
        for _, door in pairs(Workspace.Map.Doors:GetChildren()) do
            door:Destroy()
        end
    end
})

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    
    if not checkcaller() and method == "FireServer" then
        if Settings.NoBarbwire and tostring(self) == "BHHh" then
            return
        end
        if Settings.NoRagdoll and tostring(self) == "__--r" then
            return
        end
        if Settings.NoFallDamage and tostring(self) == "__DFfDD" then
            return
        end
    end
    
    return oldNamecall(self, ...)
end)

PlayerTab:AddToggle({
	Name = "NoClip",
	Default = false,
	Callback = function(Value)
        NoClipEnabled = Value
	end    
})

-- Function
game:GetService("RunService").Stepped:Connect(function()
    if NoClipEnabled and game.Players.LocalPlayer.Character then
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- No Jump Cooldown
local originalNewIndex
originalNewIndex = hookmetamethod(game, "__newindex", function(t, k, v)
    if t:IsA("Humanoid") and k == "Jump" and Settings.NoJumpCooldown then
        return
    end
    return originalNewIndex(t, k, v)
end)

-- No Flashbang
Workspace.Camera.ChildAdded:Connect(function(child)
    if child.Name == "BlindEffect" and Settings.NoFlashbang then
        child.Enabled = false
    end
end)

-- No Smoke
Workspace.Debris.ChildAdded:Connect(function(child)
    if child.Name == "SmokeExplosion" and Settings.NoSmoke then
        task.wait(0.1)
        child:Destroy()
    end
end)

-- No Fail Lockpick
LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "LockpickGUI" and Settings.NoFailLockpick then
        for _, bar in pairs(child.MF["LP_Frame"].Frames:GetChildren()) do
            if bar:FindFirstChild("Bar") then
                bar.Bar.UIScale.Scale = 10
            end
        end
    end
end)
PlayerTab:AddToggle({
    Name = "No Flashbang",
    Default = false,
    Callback = function(Value)
        Settings.NoFlashbang = Value
    end
})

PlayerTab:AddToggle({
    Name = "No Smoke Grenades",
    Default = false,
    Callback = function(Value)
        Settings.NoSmoke = Value
    end
})

PlayerTab:AddToggle({
    Name = "No Fail Lockpick",
    Default = false,
    Callback = function(Value)
        Settings.NoFailLockpick = Value
    end
})

OrionLib:Init()
