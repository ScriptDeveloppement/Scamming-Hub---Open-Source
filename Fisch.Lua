if game.PlaceId == 16732694052 then
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
local Window = OrionLib:MakeWindow({Name = "Scamming Hub - Fisch", HidePremium = false, SaveConfig = true, ConfigFolder = "Scamming Hub - Fisch"})


-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Remotes
local Remotes = {
    ReelFinished = ReplicatedStorage.events:WaitForChild("reelfinished"),
    SellAll = ReplicatedStorage.events:WaitForChild("SellAll"),
}

-- Variables
local CurrentTool = nil
local ZoneFishOrigin = nil
local State = {
    GettingMeteor = false,
    LastToolReset = os.clock(),
    ToolResetCooldown = 5,
}

-- Track coroutines
local Coroutines = {
    AutoCast = nil,
    InstantBob = nil,
    AutoReel = nil,
    InstantReel = nil,
    AutoShake = nil,
    CenterShake = nil,
}

-- Utility Functions
local function ResetTool()
    if CurrentTool then
        local ToolCache = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if CurrentTool then
            if State.LastToolReset + State.ToolResetCooldown < os.clock() then
                State.LastToolReset = os.clock()
                LocalPlayer.Character.Humanoid:UnequipTools()
                task.wait()
                ToolCache.Parent = LocalPlayer.Character
            end
        end
    end
end

-- Function to stop a coroutine
local function StopCoroutine(CoroutineName)
    if Coroutines[CoroutineName] then
        coroutine.close(Coroutines[CoroutineName])
        Coroutines[CoroutineName] = nil
    end
end

-- Auto Fish Tab
local autoFishTab = Window:MakeTab({
    Name = "Auto Fish",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Casting Section
local castingSection = autoFishTab:AddSection({
    Name = "Casting"
})

castingSection:AddToggle({
    Name = "Auto-Cast",
    Default = false,
    Callback = function(Value)
        StopCoroutine("AutoCast") -- Stop existing coroutine
        if Value then
            Coroutines.AutoCast = coroutine.create(function()
                while task.wait(0.3) and Value do
                    pcall(function()
                        if not CurrentTool then
                            CurrentTool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        end

                        if CurrentTool then
                            local Values = CurrentTool:FindFirstChild("values")
                            if Values and Values.casted.Value == false then
                                local AnimationFolder = ReplicatedStorage:WaitForChild("resources"):WaitForChild("animations")
                                local CastAnimation = LocalPlayer.Character.Humanoid:LoadAnimation(AnimationFolder.fishing.throw)
                                CastAnimation.Priority = Enum.AnimationPriority.Action3
                                CastAnimation:Play()
                                CurrentTool.events.cast:FireServer(100, 1)
                                CastAnimation.Stopped:Once(function()
                                    CastAnimation:Destroy()
                                end)
                            end
                        end
                    end)
                end
            end)
            coroutine.resume(Coroutines.AutoCast)
        end
    end
})

castingSection:AddToggle({
    Name = "Instant Bob",
    Default = false,
    Callback = function(Value)
        StopCoroutine("InstantBob") -- Stop existing coroutine
        if Value then
            Coroutines.InstantBob = coroutine.create(function()
                while task.wait() and Value do
                    pcall(function()
                        if CurrentTool then
                            local Bobber = CurrentTool:FindFirstChild("bobber")
                            if Bobber then
                                local Params = RaycastParams.new()
                                Params.FilterType = Enum.RaycastFilterType.Include
                                Params.FilterDescendantsInstances = { workspace.Terrain }
                                local RaycastResult = workspace:Raycast(Bobber.Position, -Vector3.yAxis * 100, Params)
                                if RaycastResult and RaycastResult.Instance:IsA("Terrain") then
                                    Bobber:PivotTo(CFrame.new(RaycastResult.Position))
                                end
                            end
                        end
                    end)
                end
            end)
            coroutine.resume(Coroutines.InstantBob)
        end
    end
})

-- Reeling Section
local reelingSection = autoFishTab:AddSection({
    Name = "Reeling"
})

reelingSection:AddToggle({
    Name = "Auto-Reel (Legit)",
    Default = false,
    Callback = function(Value)
        StopCoroutine("AutoReel") -- Stop existing coroutine
        if Value then
            Coroutines.AutoReel = coroutine.create(function()
                while task.wait() and Value do
                    pcall(function()
                        local ReelUI = LocalPlayer.PlayerGui:FindFirstChild("reel")
                        if ReelUI then
                            local Bar = ReelUI:FindFirstChild("bar")
                            if Bar then
                                local PlayerBar = Bar:FindFirstChild("playerbar")
                                local TargetBar = Bar:FindFirstChild("fish")
                                if PlayerBar and TargetBar then
                                    local UnfilteredTargetPosition = PlayerBar.Position:Lerp(TargetBar.Position, 0.7)
                                    local TargetPosition = UDim2.fromScale(math.clamp(UnfilteredTargetPosition.X.Scale, 0.15, 0.85), UnfilteredTargetPosition.Y.Scale)
                                    PlayerBar.Position = TargetPosition
                                end
                            end
                        end
                    end)
                end
            end)
            coroutine.resume(Coroutines.AutoReel)
        end
    end
})

reelingSection:AddToggle({
    Name = "Instant Reel (Blatant)",
    Default = false,
    Callback = function(Value)
        StopCoroutine("InstantReel") -- Stop existing coroutine
        if Value then
            Coroutines.InstantReel = coroutine.create(function()
                while task.wait() and Value do
                    pcall(function()
                        local ReelUI = LocalPlayer.PlayerGui:FindFirstChild("reel")
                        if ReelUI then
                            local Bar = ReelUI:FindFirstChild("bar")
                            if Bar then
                                local ReelScript = Bar:FindFirstChild("reel")
                                if ReelScript and ReelScript.Enabled == true then
                                    Remotes.ReelFinished:FireServer(100, true)
                                end
                            end
                        end
                    end)
                end
            end)
            coroutine.resume(Coroutines.InstantReel)
        end
    end
})

reelingSection:AddToggle({
    Name = "Always Perfect",
    Default = false,
    Callback = function(Value)
        if Value then
            hookfunction(Remotes.ReelFinished.FireServer, function(self, percentage, isPerfect)
                return Remotes.ReelFinished.FireServer(self, 100, true)
            end)
        else
            -- Restore original function if needed
        end
    end
})

-- Other Section
local otherSection = autoFishTab:AddSection({
    Name = "Other"
})

otherSection:AddToggle({
    Name = "Auto Shake",
    Default = false,
    Callback = function(Value)
        StopCoroutine("AutoShake") -- Stop existing coroutine
        if Value then
            Coroutines.AutoShake = coroutine.create(function()
                while task.wait() and Value do
                    pcall(function()
                        local ShakeUI = LocalPlayer.PlayerGui:FindFirstChild("shakeui")
                        if ShakeUI then
                            local SafeZone = ShakeUI:FindFirstChild("safezone")
                            if SafeZone then
                                -- Find the shake button
                                local ShakeButton = SafeZone:FindFirstChildWhichIsA("ImageButton")
                                if ShakeButton then
                                    -- Simulate mouse click on the shake button
                                    local ClickPosition = ShakeButton.AbsolutePosition + ShakeButton.AbsoluteSize / 2
                                    VirtualInputManager:SendMouseButtonEvent(ClickPosition.X, ClickPosition.Y, 0, true, game, 1)
                                    task.wait(0.1)
                                    VirtualInputManager:SendMouseButtonEvent(ClickPosition.X, ClickPosition.Y, 0, false, game, 1)
                                end
                            end
                        end
                    end)
                end
            end)
            coroutine.resume(Coroutines.AutoShake)
        end
    end
})

otherSection:AddToggle({
    Name = "Center Shake",
    Default = false,
    Callback = function(Value)
        StopCoroutine("CenterShake") -- Stop existing coroutine
        if Value then
            Coroutines.CenterShake = coroutine.create(function()
                while task.wait() and Value do
                    pcall(function()
                        local ShakeUI = LocalPlayer.PlayerGui:FindFirstChild("shakeui")
                        if ShakeUI then
                            local SafeZone = ShakeUI:FindFirstChild("safezone")
                            if SafeZone then
                                -- Disable the script that locks the size of the SafeZone
                                local ConnectScript = SafeZone:FindFirstChild("connect")
                                if ConnectScript then
                                    ConnectScript.Enabled = false
                                end

                                -- Center the SafeZone
                                SafeZone.Size = UDim2.fromOffset(0, 0)
                                SafeZone.Position = UDim2.fromScale(0.5, 0.5)
                                SafeZone.AnchorPoint = Vector2.new(0.5, 0.5)
                            end
                        end
                    end)
                end
            end)
            coroutine.resume(Coroutines.CenterShake)
        end
    end
})

local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local MiscTabSection = MiscTab:AddSection({
    Name = "Misc Tab Section"
})

-- Locations Dictionary
local locations = {
    ["atlantis"] = Vector3.new(-4265, -603, 1831),
    ["vertigo"] = Vector3.new(-112, -515, 1040),
    ["poseidon puzzle"] = Vector3.new(-3695, -547, 1014),
    ["moosewood"] = Vector3.new(382, 135, 244),
    ["ancientarchives"] = Vector3.new(-3155, -755, 2193),
    ["etherealpuzzle"] = Vector3.new(-4122, -602, 1821),
    ["keepers"] = Vector3.new(1296, -805, -299),
    ["archive"] = Vector3.new(1296, -805, -299),
    ["ancient"] = Vector3.new(-3158, -755, 2214),
    ["northglider"] = Vector3.new(20241, 757, 5756),
    ["arch"] = Vector3.new(999, 131, -1237),
    ["trident"] = Vector3.new(-1479, -226, -2391),
    ["peak"] = Vector3.new(19998, 1136, 5520),
    ["crafting"] = Vector3.new(-3160, -746, 1684),
    ["oilrig"] = Vector3.new(-1901, 225, -486),
    ["sunstone"] = Vector3.new(-933, 132, -1119),
    ["roslitsubmarine"] = Vector3.new(-1332, 133, 313),
    ["bosspool"] = Vector3.new(-2373, -11186, 7123),
    ["deepshop"] = Vector3.new(-979, -245, -2700),
    ["northern"] = Vector3.new(19527, 133, 5293),
    ["podium1"] = Vector3.new(-3464, -2258, 3833),
    ["snow"] = Vector3.new(2649, 142, 2521),
    ["zeuspuzzle"] = Vector3.new(-4296, -670, 2354),
    ["enchantaltar"] = Vector3.new(1311, -805, -103),
    ["podium2"] = Vector3.new(-826, -3274, -710),
    ["anglerminigame"] = Vector3.new(-10085, -9645, 275),
    ["statue"] = Vector3.new(73, 142, -1028),
    ["bunker1"] = Vector3.new(1738, 143, -2435),
    ["mushgrove"] = Vector3.new(2501, 131, -721),
    ["camp2"] = Vector3.new(19757, 415, 5407),
    ["spike"] = Vector3.new(-1255, 138, 1554),
    ["swamp"] = Vector3.new(2501, 131, -721),
    ["camp1"] = Vector3.new(20208, 208, 5279),
    ["thedepthsobby"] = Vector3.new(67, -705, 1231),
    ["anglerbaby"] = Vector3.new(-13527, -11050, 120),
    ["thedepths"] = Vector3.new(568, -704, 1231),
    ["executive"] = Vector3.new(-30, -251, 199),
    ["volcano"] = Vector3.new(-1889, 168, 329),
    ["gamma"] = Vector3.new(2233, -804, 1021),
    ["forsaken"] = Vector3.new(-2498, 137, 1625),
    ["sukenpanel"] = Vector3.new(-4615, -597, 1843),
    ["finalpuzzle"] = Vector3.new(19964, 1138, 5402)
}

-- Add the dropdown
MiscTab:AddDropdown({
    Name = "Place Teleport",  -- Name of the dropdown
    Default = "Choose your Location",  -- Default value when the GUI is opened
    Options = {
        "atlantis", "vertigo", "poseidon puzzle", "moosewood", "ancientarchives",
        "etherealpuzzle", "keepers", "archive", "ancient", "northglider", "arch",
        "trident", "peak", "crafting", "oilrig", "sunstone", "roslitsubmarine", 
        "bosspool", "deepshop", "northern", "podium1", "snow", "zeuspuzzle",
        "enchantaltar", "podium2", "anglerminigame", "statue", "bunker1", 
        "mushgrove", "camp2", "spike", "swamp", "camp1", "thedepthsobby", 
        "anglerbaby", "thedepths", "executive", "volcano", "gamma", "forsaken", 
        "sukenpanel", "finalpuzzle"
    },
    Callback = function(Value)
        -- Get the player and their character
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        -- Check if the selected value exists in the locations table
        local location = locations[Value]
        
        if location then
            -- Teleport the player to the selected location
            character:SetPrimaryPartCFrame(CFrame.new(location))
            print("Teleported to " .. Value)
        else
            print("Location not found!")
        end
    end    
})

-- Locations Dictionary for Totems
local totemLocations = {
    ["Aurora Totem"] = Vector3.new(-1811, -137, -3282),
    ["Smokescreen Totem"] = Vector3.new(2789, 140, -625),
    ["Windset Totem"] = Vector3.new(2849, 178, 2702),
    ["Tempest Totem"] = Vector3.new(35, 133, 1943),
    ["Sundial Totem"] = Vector3.new(-1148, 134, -1075),
    ["Eclipse Totem"] = Vector3.new(5968, 274, 838),
    ["Meteor Totem"] = Vector3.new(-1948, 275, 230),
    ["Bizzard Totem"] = Vector3.new(20145, 743, 5805),
    ["Avalanche Totem"] = Vector3.new(19710, 468, 6052),
    ["Zeus Storm Totem"] = Vector3.new(-4325, -628, 2686)
}

-- Add the dropdown for Totems
MiscTab:AddDropdown({
    Name = "Totem Teleport",  -- Name of the dropdown
    Default = "",  -- Default value when the GUI is opened
    Options = {
        "Aurora Totem", "Smokescreen Totem", "Windset Totem", "Tempest Totem", 
        "Sundial Totem", "Eclipse Totem", "Meteor Totem", "Bizzard Totem", 
        "Avalanche Totem", "Zeus Storm Totem"
    },  -- List of totem options
    Callback = function(Value)
        -- Get the player and their character
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        -- Check if the selected value exists in the totemLocations table
        local location = totemLocations[Value]
        
        if location then
            -- Teleport the player to the selected location
            character:SetPrimaryPartCFrame(CFrame.new(location))
            print("Teleported to " .. Value)
        else
            print("Totem location not found!")
        end
    end    
})

local teleportLocations = {
    ["Mirror Area"] = Vector3.new(-1628, -207, -2788),
    ["Inn Keeper"] = Vector3.new(-1652, -214, -2833),
    ["Mel Merchant"] = Vector3.new(-1658, -213, -2819),
    ["Clarence"] = Vector3.new(-1625, -231, -2904),
    ["Sleeper"] = Vector3.new(-1498, -235, -2852),
    ["Desolate Skin"] = Vector3.new(-1573, -289, -2966),
    ["Daisy"] = Vector3.new(582, 165, 216),
    ["Mods Lantern"] = Vector3.new(-39, -247, 196),
    ["Quiet Symph"] = Vector3.new(566, 152, 354),
    ["Lantern Keeper"] = Vector3.new(658, 164, 260),
    ["Paul"] = Vector3.new(382, 137, 347),
    ["Inn Keeper 2"] = Vector3.new(487, 151, 231),
    ["Moosewood Angler"] = Vector3.new(480, 151, 302),
    ["Marc Merchant"] = Vector3.new(466, 151, 224),
    ["Phineas"] = Vector3.new(470, 151, 278),
    ["Moosewood Skin"] = Vector3.new(416, 135, 189),
    ["Lucas"] = Vector3.new(449, 182, 181),
    ["Appraiser"] = Vector3.new(453, 151, 207),
    ["Marchent"] = Vector3.new(466, 151, 224),
    ["Henry"] = Vector3.new(484, 152, 236),
    ["Arnold"] = Vector3.new(320, 134, 264),
    ["Moosewood Shipwright"] = Vector3.new(358, 134, 258),
    ["Captain Ahab"] = Vector3.new(364, 133, 295),
    ["Quiet Synph"] = Vector3.new(566, 152, 354),
    ["Mushgrove Skin"] = Vector3.new(2643, 130, -709),
    ["Mushgrove Guard"] = Vector3.new(2521, 161, -891),
    ["Agaric"] = Vector3.new(2601, 132, -729),
    ["Jack Marrow"] = Vector3.new(-2830, 215, 1517),
    ["Forsaken Skin"] = Vector3.new(-2564, 149, 1645),
    ["Mila Merchant"] = Vector3.new(-2509, 136, 1583),
    ["Spirit of Zeus"] = Vector3.new(-4296, -673, 2354),
    ["Spirit of Hades"] = Vector3.new(-4414, -996, 2048),
    ["Myron Merchant"] = Vector3.new(-4458, -606, 1880),
    ["Spirit of Cronus"] = Vector3.new(-4184, -887, 1828),
    ["Spirit of Athena"] = Vector3.new(-4588, -597, 1846),
    ["Spirit of Ares"] = Vector3.new(-4586, -597, 1839),
    ["Spirit of Nyx"] = Vector3.new(-4449, -594, 1804),
    ["Spirit of Apollo"] = Vector3.new(-4290, -595, 1795),
    ["Inn Keeper Atlantis"] = Vector3.new(-4275, -603, 1818),
    ["Perditus"] = Vector3.new(770, -729, 1385),
    ["Milo Merchant"] = Vector3.new(957, -712, 1263),
    ["The Depths Angler"] = Vector3.new(982, -703, 1232),
    ["Occultus"] = Vector3.new(1023, -703, 1564),
    ["Tenebris"] = Vector3.new(1061, -629, 1310),
    ["The Depths Skin"] = Vector3.new(1037, -806, 1444),
    ["Submersus"] = Vector3.new(1211, -1011, 1316),
    ["Aspicientis"] = Vector3.new(1215, -707, 1321),
    ["Abyssus"] = Vector3.new(1397, -1013, 965),
    ["???"] = Vector3.new(-86, -515, 1136),
    ["Custos"] = Vector3.new(22, -706, 1253),
    ["Leeris"] = Vector3.new(-142, -548, 1426),
    ["Synph"] = Vector3.new(-138, -512, 1132),
    ["Mike Merchant"] = Vector3.new(2718, 157, 2374),
    ["Wilson"] = Vector3.new(2941, 281, 2570),
    ["Snowcap Shipwright"] = Vector3.new(2623, 136, 2401),
    ["Snowcap Skin"] = Vector3.new(2652, 138, 2538),
    ["Mann Merchant"] = Vector3.new(6081, 195, 309),
    ["Chiseler"] = Vector3.new(6087, 195, 295),
    ["Meteoriticist"] = Vector3.new(5922, 262, 596)
}

local dropdownOptions = {}
for name, _ in pairs(teleportLocations) do
    table.insert(dropdownOptions, name)
end

MiscTab:AddDropdown({
    Name = "NPC Tp", 
    Default = "",
    Options = dropdownOptions,
    Callback = function(Value)
        local location = teleportLocations[Value]
        if location then
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(location))
        end
    end    
})


local localuser = Window:MakeTab({
    Name = "Local Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local localPlayerSection = localuser:AddSection({
    Name = "Local Player Section"
})

-- Variables
local NoclipEnabled = false
local InfiniteJumpEnabled = false
local ControlClickTPEnabled = false
local WalkspeedApplyEnabled = false
local JumppowerApplyEnabled = false
local FlyEnabled = false
local CurrentWalkspeed = 16
local CurrentJumppower = 50


local function Noclip()
    while NoclipEnabled do
        task.wait()
        pcall(function()
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
    -- Restore collision when noclip is turned off
    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

localPlayerSection:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(Value)
        NoclipEnabled = Value
        if Value then
            coroutine.resume(coroutine.create(Noclip))
        end
    end
})
-- Infinite Jump Toggle
localPlayerSection:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        InfiniteJumpEnabled = Value
        if Value then
            UserInputService.JumpRequest:Connect(function()
                if InfiniteJumpEnabled then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                end
            end)
        end
    end
})

-- Control + Click TP Toggle
localPlayerSection:AddToggle({
    Name = "Control + Click TP",
    Default = false,
    Callback = function(Value)
        ControlClickTPEnabled = Value
        if Value then
            local Connection
            Connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    local Mouse = LocalPlayer:GetMouse()
                    local Target = Mouse.Hit.Position
                    LocalPlayer.Character:MoveTo(Target)
                end
            end)
            -- Disconnect when toggle is off
            if not Value then
                Connection:Disconnect()
            end
        end
    end
})

-- Walkspeed Apply Toggle
localPlayerSection:AddToggle({
    Name = "Apply Walkspeed",
    Default = false,
    Callback = function(Value)
        WalkspeedApplyEnabled = Value
        if Value then
            coroutine.resume(coroutine.create(function()
                while WalkspeedApplyEnabled do
                    task.wait()
                    pcall(function()
                        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = CurrentWalkspeed
                    end)
                end
            end))
        end
    end
})

-- Walkspeed Changer (Slider)
localPlayerSection:AddSlider({
    Name = "Walkspeed",
    Min = 16,
    Max = 100,
    Default = 16,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "studs",
    Callback = function(Value)
        CurrentWalkspeed = Value
        if WalkspeedApplyEnabled then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
        end
    end
})

-- Jumppower Apply Toggle
localPlayerSection:AddToggle({
    Name = "Apply Jumppower",
    Default = false,
    Callback = function(Value)
        JumppowerApplyEnabled = Value
        if Value then
            coroutine.resume(coroutine.create(function()
                while JumppowerApplyEnabled do
                    task.wait()
                    pcall(function()
                        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = CurrentJumppower
                    end)
                end
            end))
        end
    end
})

-- Jumppower Changer (Slider)
localPlayerSection:AddSlider({
    Name = "Jumppower",
    Min = 50,
    Max = 200,
    Default = 50,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "studs",
    Callback = function(Value)
        CurrentJumppower = Value
        if JumppowerApplyEnabled then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = Value
        end
    end
})

local FlyEnabled = false
local FlySpeed = 50
local flying = false

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.Velocity = Vector3.new(0, 0, 0)
bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.CFrame = character.HumanoidRootPart.CFrame
bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)

local function startFlying()
    flying = true
    bodyVelocity.Parent = character.HumanoidRootPart
    bodyGyro.Parent = character.HumanoidRootPart
    humanoid.PlatformStand = true
end

local function stopFlying()
    flying = false
    bodyVelocity.Parent = nil
    bodyGyro.Parent = nil
    humanoid.PlatformStand = false
end

game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
    if FlyEnabled and flying then
        local moveDirection = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + (workspace.CurrentCamera.CFrame.LookVector)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - (workspace.CurrentCamera.CFrame.LookVector)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - (workspace.CurrentCamera.CFrame.RightVector)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + (workspace.CurrentCamera.CFrame.RightVector)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end

        bodyVelocity.Velocity = moveDirection * FlySpeed
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
    end
end)

localPlayerSection:AddToggle({
    Name = "Fly",
    Default = false,
    Callback = function(Value)
        FlyEnabled = Value
        if Value then
            startFlying()
        else
            stopFlying() 
        end
    end
})

localPlayerSection:AddSlider({
    Name = "Fly Speed",
    Min = 10,
    Max = 200,
    Default = 50,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "speed",
    Callback = function(Value)
        FlySpeed = Value
    end
})

OrionLib:Init()
else
    game.Players.LocalPlayer:Kick("You are not in the selected game, please join fisch and execute this script")
end
